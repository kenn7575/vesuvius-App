import 'package:app/core/connection/network_info.dart';
import 'package:app/core/security/authenticated_dio_client.dart';
import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/order/business/usecases/create_new_order.dart';
import 'package:app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:app/features/order/data/repositories/order_repository_impl.dart';
import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
import 'package:app/utils/generate_comment.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';

class OrderProvider extends ChangeNotifier {
  CreateOrderParams?
      createOrderParams; // This is the state that will be used to create a new order
  OrderEntity?
      orderEntity; // after creating a new order, this state will be updated with the new order
  Failure? failure; // This will be used to display errors
  final Set<CreateOrderTableParams> selectedTables = {};

  OrderProvider({
    this.createOrderParams,
    this.orderEntity,
    this.failure,
  }) {
    createOrderParams = CreateOrderParams(menuItems: [], tables: []);
  }
  void selectTable({TableEntity? table, ReservationEntity? reservation}) {
    if (table == null && reservation?.reservationTables?.isEmpty == true) {
      return;
    }
    if (table != null) {
      CreateOrderTableParams cotp = CreateOrderTableParams(
        tableId: table.id,
      );
      createOrderParams?.tables.add(cotp);
      selectedTables.add(cotp);
    } else {
      //reset the selected tables first
      selectedTables.clear();
      createOrderParams?.tables.clear();
      reservation?.reservationTables?.forEach((element) {
        CreateOrderTableParams cotp = CreateOrderTableParams(
          tableId: element.tableId,
        );
        selectedTables.add(cotp);
        createOrderParams?.tables.add(cotp);
      });
    }

    notifyListeners();
  }

  void deselectTable(TableEntity table) {
    selectedTables.removeWhere((element) => element.tableId == table.id);
    createOrderParams?.tables
        .removeWhere((element) => element.tableId == table.id);

    notifyListeners();
  }

  void clearSelectedTables() {
    selectedTables.clear();
    createOrderParams?.tables.clear();
    notifyListeners();
  }

  int addMenuItemToOrder(CreateOrderItemParams createOrderItemParams) {
    // Check if the item is already in the cart
    CreateOrderItemParams? existingItem;
    try {
      existingItem = createOrderParams?.menuItems.firstWhere(
        (item) => item.menuItemId == createOrderItemParams.menuItemId,
      );
    } catch (e) {
      existingItem = null;
    }

    if (existingItem != null) {
      // If the item is already in the cart, increase the quantity
      existingItem.count += createOrderItemParams.count;
    } else {
      // If the item is not in the cart, add it to the cart
      createOrderParams?.menuItems.add(createOrderItemParams);
    }

    final int index = createOrderParams?.menuItems.length ?? -1;
    notifyListeners();
    return index;
  }

  int removeMenuItemFromOrder(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems.remove(createOrderItemParams);
    final int index =
        createOrderParams?.menuItems.indexOf(createOrderItemParams) ?? -1;
    notifyListeners();
    return index;
  }

  void subtractQuantity(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems
        .firstWhere((element) => element == createOrderItemParams)
        .count--;

    notifyListeners();
  }

  void commentOnOrderItem(
      CreateOrderItemParams createOrderItemParams, String? newComment) {
    if (newComment != null && newComment.isEmpty) {
      newComment = null;
    }
    // Find the item to be commented on
    final item = createOrderParams?.menuItems
        .firstWhere((element) => element == createOrderItemParams);

    if (item != null) {
      // Check if there are other items with the same menuItemId and comment
      CreateOrderItemParams? duplicateItem;
      try {
        duplicateItem = createOrderParams?.menuItems.firstWhere(
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
        duplicateItem.count += item.count;
        // Remove the original item
        createOrderParams?.menuItems.remove(item);
      } else {
        // Update the comment
        item.comment = newComment;
      }
      print(createOrderParams?.menuItems.length);
    }

    notifyListeners();
  }

  void dublicateOrderItem(CreateOrderItemParams createOrderItemParams) {
    String baseComment = createOrderItemParams.comment ?? "Copy";
    int copyNumber = 0;
    String newComment = generateComment(baseComment, copyNumber);

    while (createOrderParams?.menuItems.any((item) =>
            item.menuItemId == createOrderItemParams.menuItemId &&
            item.comment == newComment) ??
        false) {
      copyNumber++;
      newComment = generateComment(baseComment, copyNumber);
    }

    CreateOrderItemParams itemCopy = CreateOrderItemParams(
      menuItemId: createOrderItemParams.menuItemId,
      count: 1,
      comment: newComment,
    );

    createOrderParams?.menuItems.add(itemCopy);
    notifyListeners();
  }

  void placeOrderOrFailure() async {
    NewOrderRepositoryImpl repository = NewOrderRepositoryImpl(
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
        failure = newFailure;
        notifyListeners();
      },
      (newPokemon) {
        orderEntity = newPokemon;
        failure = null;
        notifyListeners();
      },
    );
  }
}
