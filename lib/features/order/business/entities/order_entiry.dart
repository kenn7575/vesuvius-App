import 'package:app/features/order/business/entities/order_item_entity.dart';
import 'package:app/features/order/business/entities/order_table_entity.dart';

class OrderEntity {
  final int id;
  final int waiterId;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final List<OrderItemEntity>? orderItems;
  final List<OrderTableEntity>? orderTables;

  const OrderEntity({
    required this.id,
    this.comment,
    required this.waiterId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.orderItems,
    this.orderTables,
  });
}
