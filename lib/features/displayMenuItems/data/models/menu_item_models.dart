import '../../business/entities/menu_item_entity.dart';

class MenuItemModel extends MenuItemEntity {
  const MenuItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.type_id,
    required super.created_at,
    required super.updated_at,
    required super.price_in_oere,
    required super.is_active,
  }) : super();

  factory MenuItemModel.fromJson({required Map<String, dynamic> json}) {
    return MenuItemModel(
      id: json[kId],
      name: json[kName],
      description: json[kDescription],
      type_id: json[kTypeId],
      price_in_oere: json[kPriceInOere],
      created_at: json[kCreatedAt],
      updated_at: json[kUpdatedAt],
      is_active: json[kIsActive],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kName: name,
      kDescription: description,
      kTypeId: type_id,
      kPriceInOere: price_in_oere,
      kCreatedAt: created_at,
      kUpdatedAt: updated_at,
      kIsActive: is_active,
    };
  }
}

// constants
String kId = 'id';
String kName = 'name';
String kCreatedAt = 'created_at';
String kUpdatedAt = 'updated_at';
String kIsActive = 'is_active';
String kDescription = 'description';
String kTypeId = 'type_id';
String kPriceInOere = 'price_in_oere';
