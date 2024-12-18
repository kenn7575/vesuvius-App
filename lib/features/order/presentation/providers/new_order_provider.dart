import 'dart:ffi';

import 'package:app/core/connection/network_info.dart';
import 'package:app/core/params/params.dart';
import 'package:app/core/security/authenticated_dio_client.dart';
import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/order/business/usecases/create_new_order.dart';
import 'package:app/features/order/business/usecases/get_order.dart';
import 'package:app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:app/features/order/data/models/params/create_order_item_params_model.dart';
import 'package:app/features/order/data/models/params/create_order_params_model.dart';
import 'package:app/features/order/data/models/params/create_order_table_params_model.dart';
import 'package:app/features/order/data/repositories/order_repository_impl.dart';
import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
import 'package:app/utils/generate_comment.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:app/core/errors/failure.dart';

class OrderProvider extends ChangeNotifier {
  CreateOrderParamsModel?
      createOrderParams; // This is the state that will be used to create a new order
  OrderEntity?
      orderEntity; // after creating a new order, this state will be updated with the new order
  Failure? failure; // This will be used to display errors
  final Set<CreateOrderTableParamsModel> selectedTables = {};
  bool isNewOrder = false;

  OrderProvider({
    this.createOrderParams,
    this.orderEntity,
    this.failure,
  }) {
    createOrderParams = CreateOrderParamsModel(orderItems: [], orderTables: []);
  }
  void selectTable({TableEntity? table, ReservationEntity? reservation}) {
    if (table == null && reservation?.reservationTables?.isEmpty == true) {
      return;
    }
    if (table != null) {
      CreateOrderTableParamsModel cotp = CreateOrderTableParamsModel(
        tableId: table.id,
      );
      createOrderParams?.orderTables.add(cotp);
      selectedTables.add(cotp);
    } else {
      //reset the selected tables first
      selectedTables.clear();
      createOrderParams?.orderTables.clear();
      reservation?.reservationTables?.forEach((element) {
        CreateOrderTableParamsModel cotp = CreateOrderTableParamsModel(
          tableId: element.tableId,
        );
        selectedTables.add(cotp);
        createOrderParams?.orderTables.add(cotp);
      });
    }

    notifyListeners();
  }

  void deselectTable(TableEntity table) {
    selectedTables.removeWhere((element) => element.tableId == table.id);
    createOrderParams?.orderTables
        .removeWhere((element) => element.tableId == table.id);

    notifyListeners();
  }

  void clearSelectedTables() {
    selectedTables.clear();
    createOrderParams?.orderTables.clear();
    notifyListeners();
  }

  int addMenuItemToOrder(CreateOrderItemParamsModel createOrderItemParams) {
    // Check if the item is already in the cart
    CreateOrderItemParamsModel? existingItem;
    try {
      existingItem = createOrderParams?.orderItems.firstWhere(
        (item) => item.menuItemId == createOrderItemParams.menuItemId,
      );
    } catch (e) {
      existingItem = null;
    }

    if (existingItem != null) {
      // If the item is already in the cart, increase the quantity
      existingItem.quantity += createOrderItemParams.quantity;
    } else {
      // If the item is not in the cart, add it to the cart
      createOrderParams?.orderItems.add(createOrderItemParams);
    }

    final int index = createOrderParams?.orderItems.length ?? -1;
    notifyListeners();
    return index;
  }

  int removeMenuItemFromOrder(
      CreateOrderItemParamsModel createOrderItemParams) {
    createOrderParams?.orderItems.remove(createOrderItemParams);
    final int index =
        createOrderParams?.orderItems.indexOf(createOrderItemParams) ?? -1;
    notifyListeners();
    return index;
  }

  void subtractQuantity(CreateOrderItemParamsModel createOrderItemParams) {
    createOrderParams?.orderItems
        .firstWhere((element) => element == createOrderItemParams)
        .quantity--;

    notifyListeners();
  }

  void commentOnOrderItem(
      CreateOrderItemParamsModel createOrderItemParams, String? newComment) {
    if (newComment != null && newComment.isEmpty) {
      newComment = null;
    }
    // Find the item to be commented on
    final item = createOrderParams?.orderItems
        .firstWhere((element) => element == createOrderItemParams);

    if (item != null) {
      // Check if there are other items with the same menuItemId and comment
      CreateOrderItemParamsModel? duplicateItem;
      try {
        duplicateItem = createOrderParams?.orderItems.firstWhere(
          (element) =>
              element.menuItemId == item.menuItemId &&
              (element.comment == newComment) &&
              element != item,
        );
      } catch (e) {
        duplicateItem = null;
      }

      if (duplicateItem != null) {
        // Merge the items by incrementing the count
        duplicateItem.quantity += item.quantity;
        // Remove the original item
        createOrderParams?.orderItems.remove(item);
      } else {
        // Update the comment
        item.comment = newComment;
      }
      print(createOrderParams?.orderItems.length);
    }

    notifyListeners();
  }

  void dublicateOrderItem(CreateOrderItemParamsModel createOrderItemParams) {
    String baseComment = createOrderItemParams.comment ?? "Copy";
    int copyNumber = 0;
    String newComment = generateComment(baseComment, copyNumber);

    while (createOrderParams?.orderItems.any((item) =>
            item.menuItemId == createOrderItemParams.menuItemId &&
            item.comment == newComment) ??
        false) {
      copyNumber++;
      newComment = generateComment(baseComment, copyNumber);
    }

    CreateOrderItemParamsModel itemCopy = CreateOrderItemParamsModel(
      menuItemId: createOrderItemParams.menuItemId,
      quantity: 1,
      comment: newComment,
    );

    createOrderParams?.orderItems.add(itemCopy);
    notifyListeners();
  }

  Future<void> setIsNewOrder(bool value) async {
    isNewOrder = value;
    notifyListeners();
  }

  Future<void> eitherFailureOrOrder({required String orderId}) async {
    OrderRepositoryImpl repository = OrderRepositoryImpl(
      remoteDataSource:
          OrderRemoteDataSourceImpl(dioWithAuth: AuthenticatedDioClient()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    //check if orderId is a number
    if (int.tryParse(orderId) == null) {
      failure = ServerFailure(errorMessage: 'Invalid order id');
      notifyListeners();
      return;
    }

    final faliureOrorderEntity = await GetOrder(orderRepository: repository)
        .call(getOrderParams: GetOrderParams(orderId: int.parse(orderId)));

    faliureOrorderEntity.fold(
      (newFailure) {
        orderEntity = null;
        isNewOrder = false;
        failure = newFailure;
        notifyListeners();
      },
      (newOrder) {
        orderEntity = newOrder;
        isNewOrder = false;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future<void> placeOrderOrFailure() async {
    OrderRepositoryImpl repository = OrderRepositoryImpl(
      remoteDataSource:
          OrderRemoteDataSourceImpl(dioWithAuth: AuthenticatedDioClient()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    if (createOrderParams == null) {
      failure = ServerFailure(errorMessage: 'No order items');
      notifyListeners();
      return;
    }

    final faliureOrorderEntity =
        await CreateNewOrder(newOrderRepository: repository).call(
      createOrderParams: createOrderParams!,
    );

    faliureOrorderEntity.fold(
      (newFailure) {
        orderEntity = null;
        isNewOrder = false;
        failure = newFailure;
        notifyListeners();
      },
      (newOrder) {
        orderEntity = newOrder;
        isNewOrder = true;
        failure = null;
        notifyListeners();
      },
    );
  }
}
