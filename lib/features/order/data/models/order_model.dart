import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/order/data/models/order_item_model.dart';
import 'package:app/features/order/data/models/order_table_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    super.comment,
    required super.waiterId,
    required super.createdAt,
    required super.updatedAt,
    super.orderItems,
    required super.status,
    super.orderTables,
  });

  factory OrderModel.fromJson({required Map<String, dynamic> json}) {
    return OrderModel(
      id: json[kId],
      comment: json[kComment],
      waiterId: json[kWaiterId],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
      status: json[kStatus],
      orderItems: OrderItemModel.fromJsonList(json[kOrderItems]),
      orderTables: OrderTableModel.fromJsonList(json[kOrderTables]),
    );
  }
  static List<OrderModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderModel.fromJson(json: json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<OrderModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kComment: comment,
      kWaiterId: waiterId,
      kCreatedAt: createdAt.toIso8601String(),
      kUpdatedAt: updatedAt.toIso8601String(),
      kStatus: status,
      kOrderItems:
          OrderItemModel.toJsonList(orderItems?.cast<OrderItemModel>() ?? []),
      kOrderTables: OrderTableModel.toJsonList(
          orderTables?.cast<OrderTableModel>() ?? []),
    };
  }
}

const String kId = 'id';
const String kComment = 'comment';
const String kWaiterId = 'waiter_id';
const String kCreatedAt = 'created_at';
const String kUpdatedAt = 'updated_at';
const String kStatus = 'status';
const String kOrderItems = 'order_items';
const String kOrderTables = 'order_tables';
