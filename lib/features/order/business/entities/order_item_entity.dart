class OrderItemEntity {
  final int id;
  final int orderId;
  final int menuItemId;
  final int quantity;
  final String? comment;
  final int priceInOere;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.menuItemId,
    required this.quantity,
    this.comment,
    required this.priceInOere,
  });
}
