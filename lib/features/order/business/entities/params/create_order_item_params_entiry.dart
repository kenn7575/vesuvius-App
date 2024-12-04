class CreateOrderItemParamsEntiry {
  int menuItemId;
  int quantity;
  String? comment;
  String? name;
  CreateOrderItemParamsEntiry({
    required this.menuItemId,
    required this.quantity,
    this.comment,
    this.name,
  });
}
