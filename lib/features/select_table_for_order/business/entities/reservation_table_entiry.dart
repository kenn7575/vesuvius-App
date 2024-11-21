class ReservationTableEntity {
  final int id;
  final int? orderId;
  final int? reservationId;
  final int tableId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReservationTableEntity({
    required this.id,
    this.orderId,
    this.reservationId,
    required this.tableId,
    required this.createdAt,
    required this.updatedAt,
  });
}
