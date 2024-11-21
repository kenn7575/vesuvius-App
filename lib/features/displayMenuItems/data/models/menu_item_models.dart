import '../../business/entities/menu_item_entity.dart';

class MenuItemModel extends MenuItemEntity {
  const MenuItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.typeId,
    required super.createdAt,
    required super.updatedAt,
    required super.priceInOere,
    required super.isActive,
    required super.isSoldOut,
    required super.isLackingIngredient,
    required super.comment,
  }) : super();

  factory MenuItemModel.fromJson({required Map<String, dynamic> json}) {
    return MenuItemModel(
      id: json[kId],
      name: json[kName],
      description: json[kDescription],
      typeId: json[kTypeId],
      priceInOere: json[kPriceInOere],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kCreatedAt]),
      isActive: json[kIsActive],
      isSoldOut: json[kIsSoldOut],
      isLackingIngredient: json[kIsLackingIngredient],
      comment: json[kComment],
    );
  }

  static List<MenuItemModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MenuItemModel.fromJson(json: json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kName: name,
      kDescription: description,
      kTypeId: typeId,
      kPriceInOere: priceInOere,
      kCreatedAt: createdAt.toIso8601String(),
      kUpdatedAt: updatedAt.toIso8601String(),
      kIsActive: isActive,
      kIsSoldOut: isSoldOut,
      kIsLackingIngredient: isLackingIngredient,
      kComment: comment,
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<MenuItemModel> models) {
    return models.map((model) => model.toJson()).toList();
  }
}

// constants
const String kId = 'id';
const String kName = 'name';
const String kCreatedAt = 'created_at';
const String kUpdatedAt = 'updated_at';
const String kIsActive = 'is_active';
const String kDescription = 'description';
const String kTypeId = 'type_id';
const String kPriceInOere = 'price_in_oere';
const String kIsSoldOut = 'is_sold_out';
const String kIsLackingIngredient = 'is_lacking_ingredient';
const String kComment = 'comment';
