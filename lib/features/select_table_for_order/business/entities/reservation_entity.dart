import 'package:app/features/select_table_for_order/business/entities/reservation_table_entiry.dart';

class ReservationEntity {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime time;
  final int durationInMinutes;
  final int numberOfPeople;
  final int? waiterId;
  final String status;
  final String? comment;
  final String customerName;
  final String customerPhoneNumber;
  final List<ReservationTableEntity>? reservationTables;

  const ReservationEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.time,
    required this.durationInMinutes,
    required this.numberOfPeople,
    this.waiterId,
    required this.status,
    this.comment,
    required this.customerName,
    required this.customerPhoneNumber,
    this.reservationTables,
  });
}
