class MenuItemEntity {
  final int id;
  final String name;
  final String description;
  final int type_id;
  final DateTime created_at;
  final DateTime updated_at;
  final bool is_active;
  final int price_in_oere;

  const MenuItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.type_id,
    required this.created_at,
    required this.updated_at,
    required this.is_active,
    required this.price_in_oere,
  });
}
