import 'package:app/features/order/business/entities/params/create_order_item_params_entiry.dart';

class CreateOrderItemParamsModel extends CreateOrderItemParamsEntiry {
  CreateOrderItemParamsModel({
    required super.menuItemId,
    required super.quantity,
    super.comment,
    super.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateOrderItemParamsModel) return false;
    return other.menuItemId == menuItemId &&
        other.quantity == quantity &&
        other.comment == comment;
  }

  @override
  int get hashCode => Object.hash(menuItemId, quantity, comment);

  factory CreateOrderItemParamsModel.fromJson(
      {required Map<String, dynamic> json}) {
    return CreateOrderItemParamsModel(
      menuItemId: json[kMenuItemId],
      quantity: json[kQuantity],
      comment: json[kComment],
      name: json[kName],
    );
  }

  static List<CreateOrderItemParamsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CreateOrderItemParamsModel.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CreateOrderItemParamsModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  // dont include name in toJson because its only used in UI
  Map<String, dynamic> toJson() {
    return {
      kMenuItemId: menuItemId,
      kQuantity: quantity,
      kComment: comment,
    };
  }
}

const String kMenuItemId = 'menu_item_id';
const String kQuantity = 'quantity';
const String kComment = 'comment';
const String kName = 'name';
