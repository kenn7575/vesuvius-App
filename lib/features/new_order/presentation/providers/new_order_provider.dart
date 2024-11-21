import 'package:app/features/new_order/business/entities/order_entiry.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';

class TemplateProvider extends ChangeNotifier {
  CreateOrderParams?
      createOrderParams; // This is the state that will be used to create a new order
  OrderEntity?
      orderEntity; // after creating a new order, this state will be updated with the new order
  Failure? failure; // This will be used to display errors

  TemplateProvider({
    this.createOrderParams,
    this.orderEntity,
    this.failure,
  }) {
    createOrderParams = CreateOrderParams(menuItems: [], tables: []);
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
