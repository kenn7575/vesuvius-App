class MenuItemEntity {
  final int id;
  final String name;
  final String description;
  final int typeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final int priceInOere;
  final bool isSoldOut;
  final bool isLackingIngredient;
  final String? comment;

  const MenuItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.priceInOere,
    required this.isSoldOut,
    required this.isLackingIngredient,
    this.comment,
  });
}
