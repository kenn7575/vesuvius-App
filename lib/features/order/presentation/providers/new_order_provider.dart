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
    print(selectedTables.length);

    notifyListeners();
  }

  void deselectTable(TableEntity table) {
    selectedTables.removeWhere((element) => element.tableId == table.id);
    createOrderParams?.tables
        .removeWhere((element) => element.tableId == table.id);
    print(selectedTables.toString());

    notifyListeners();
  }

  void clearSelectedTables() {
    selectedTables.clear();
    createOrderParams?.tables.clear();
    notifyListeners();
  }

  void addMenuItemToOrder(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems.add(createOrderItemParams);
    notifyListeners();
  }

  void removeMenuItemFromOrder(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems.remove(createOrderItemParams);
    notifyListeners();
  }

  void subtractQuantity(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems
        .firstWhere((element) => element == createOrderItemParams)
        .count--;
    notifyListeners();
  }

  void addQuantity(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems
        .firstWhere((element) => element == createOrderItemParams)
        .count++;
    notifyListeners();
  }

  void commentOnOrderItem(CreateOrderItemParams createOrderItemParams) {
    createOrderParams?.menuItems
        .firstWhere((element) => element == createOrderItemParams)
        .comment = createOrderItemParams.comment;
    notifyListeners();
  }
}
