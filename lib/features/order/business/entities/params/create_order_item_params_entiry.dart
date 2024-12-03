class CreateOrderItemParamsEntiry {
  int menuItemId;
  int quantity;
  String? comment;
  CreateOrderItemParamsEntiry({
    required this.menuItemId,
    required this.quantity,
    this.comment,
  });
}
