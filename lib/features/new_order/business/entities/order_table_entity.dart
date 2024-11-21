class OrderTableEntity {
  final int id;
  final int? orderId;
  final int tableId;
  final int? reservationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderTableEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.tableId,
    this.orderId,
    this.reservationId,
  });
}
