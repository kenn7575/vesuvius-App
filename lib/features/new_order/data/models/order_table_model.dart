// final int id;
//   final int? orderId;
//   final int tableId;
//   final int? reservationId;
//   final DateTime createdAt;
//   final DateTime updatedAt;

import 'package:app/features/new_order/business/entities/order_table_entity.dart';

class OrderTableModel extends OrderTableEntity {
  const OrderTableModel({
    required super.id,
    super.orderId,
    required super.createdAt,
    required super.updatedAt,
    required super.tableId,
    super.reservationId,
  });

  factory OrderTableModel.fromJson({required Map<String, dynamic> json}) {
    return OrderTableModel(
      id: json[kId],
      orderId: json[kOrderId],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
      tableId: json[kTableId],
      reservationId: json[kReservationId],
    );
  }
  static List<OrderTableModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => OrderTableModel.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<OrderTableModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kOrderId: orderId,
      kCreatedAt: createdAt.toIso8601String(),
      kUpdatedAt: updatedAt.toIso8601String(),
      kTableId: tableId,
      kReservationId: reservationId,
    };
  }
}

const String kId = 'id';
const String kOrderId = 'order_id';
const String kTableId = 'table_id';
const String kReservationId = 'reservation_id';
const String kCreatedAt = 'created_at';
const String kUpdatedAt = 'updated_at';
