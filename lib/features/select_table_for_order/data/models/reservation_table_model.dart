import 'package:app/features/select_table_for_order/business/entities/reservation_table_entiry.dart';

class ReservationTableModel extends ReservationTableEntity {
  const ReservationTableModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.tableId,
    super.orderId,
    super.reservationId,
  });

  factory ReservationTableModel.fromJson({required Map<String, dynamic> json}) {
    return ReservationTableModel(
      id: json[kId],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
      tableId: json[kTableId],
      orderId: json[kOrderId],
      reservationId: json[kReservationId],
    );
  }
  static List<ReservationTableModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ReservationTableModel.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<ReservationTableModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kCreatedAt: createdAt.toIso8601String(),
      kUpdatedAt: updatedAt.toIso8601String(),
    };
  }
}

const String kId = 'id';
const String kOrderId = 'order_id';
const String kTableId = 'table_id';
const String kReservationId = 'reservation_id';
const String kCreatedAt = 'created_at';
const String kUpdatedAt = 'updated_at';
