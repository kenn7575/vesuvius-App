class MenuItemTypeEntity {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFood;

  const MenuItemTypeEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isFood,
  });
}
