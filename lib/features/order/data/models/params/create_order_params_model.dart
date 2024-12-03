import 'package:app/features/order/business/entities/params/create_order_params_entiry.dart';
import 'package:app/features/order/data/models/params/create_order_item_params_model.dart';
import 'package:app/features/order/data/models/params/create_order_table_params_model.dart';

class CreateOrderParamsModel extends CreateOrderParamsEntiry {
  CreateOrderParamsModel({
    super.waiterId,
    required super.orderItems,
    required super.orderTables,
    super.comment,
  });

  factory CreateOrderParamsModel.fromJson(
      {required Map<String, dynamic> json}) {
    return CreateOrderParamsModel(
      waiterId: json[kWaiterId],
      comment: json[kComment],
      orderItems: CreateOrderItemParamsModel.fromJsonList(json[kOrderItems]),
      orderTables: CreateOrderTableParamsModel.fromJsonList(json[kOrderTables]),
    );
  }
  static List<CreateOrderParamsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CreateOrderParamsModel.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CreateOrderParamsModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kComment: comment,
      kWaiterId: waiterId,
      kOrderItems: CreateOrderItemParamsModel.toJsonList(
          orderItems.cast<CreateOrderItemParamsModel>()),
      kOrderTables: CreateOrderTableParamsModel.toJsonList(
          orderTables.cast<CreateOrderTableParamsModel>()),
    };
  }
}

const String kComment = 'comment';
const String kWaiterId = 'waiter_id';
const String kOrderItems = 'order_items';
const String kOrderTables = 'order_tables';
