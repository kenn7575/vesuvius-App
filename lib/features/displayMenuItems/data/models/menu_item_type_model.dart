import '../../business/entities/menu_item_types_entity.dart';

class MenuItemTypeModel extends MenuItemTypeEntity {
  const MenuItemTypeModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MenuItemTypeModel.fromJson({required Map<String, dynamic> json}) {
    return MenuItemTypeModel(
      id: json[kId],
      name: json[kName],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
    );
  }

  static List<MenuItemTypeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => MenuItemTypeModel.fromJson(json: json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kName: name,
      kCreatedAt: createdAt.toIso8601String(),
      kUpdatedAt: updatedAt.toIso8601String(),
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<MenuItemTypeModel> models) {
    return models.map((model) => model.toJson()).toList();
  }
}

// constants
const String kId = 'id';
const String kName = 'name';
const String kCreatedAt = 'created_at';
const String kUpdatedAt = 'updated_at';
