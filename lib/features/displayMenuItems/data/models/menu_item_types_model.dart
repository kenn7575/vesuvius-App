import '../../business/entities/menu_item_types_entity.dart';

class MenuItemTypesModel extends MenuItemTypesEntity {
  const MenuItemTypesModel({
    required super.id,
    required super.name,
    required super.created_at,
    required super.updated_at,
  });

  factory MenuItemTypesModel.fromJson({required Map<String, dynamic> json}) {
    return MenuItemTypesModel(
      id: json[kId],
      name: json[kName],
      created_at: json[kCreatedAt],
      updated_at: json[kUpdatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kName: name,
      kCreatedAt: created_at,
      kUpdatedAt: updated_at,
    };
  }
}

// constants
String kId = 'id';
String kName = 'name';
String kCreatedAt = 'created_at';
String kUpdatedAt = 'updated_at';
