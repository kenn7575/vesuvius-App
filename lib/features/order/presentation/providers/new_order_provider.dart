import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
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

    int totalMenuItemCount = 0;
    for (CreateOrderItemParams item in createOrderParams?.menuItems ?? []) {
      totalMenuItemCount += item.count;
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

  void commentOnOrderItem(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems
        .firstWhere((element) => element == createOrderItemParams)
        .comment = createOrderItemParams.comment;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
