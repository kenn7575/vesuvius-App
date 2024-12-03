import '../../business/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.orderId,
    required super.menuItemId,
    required super.quantity,
    super.comment,
    required super.priceInOere,
  });

  factory OrderItemModel.fromJson({required Map<String, dynamic> json}) {
    return OrderItemModel(
      id: json[kId],
      orderId: json[kOrderId],
      menuItemId: json[kMenuItemId],
      quantity: json[kQuantity],
      comment: json[kComment],
      priceInOere: json[kPriceInOere],
    );
  }
  static List<OrderItemModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderItemModel.fromJson(json: json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<OrderItemModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kOrderId: orderId,
      kMenuItemId: menuItemId,
      kQuantity: quantity,
      kComment: comment,
      kPriceInOere: priceInOere,
    };
  }
}

const String kId = 'id';
const String kOrderId = 'order_id';
const String kMenuItemId = 'menu_item_id';
const String kQuantity = 'count';
const String kComment = 'comment';
const String kPriceInOere = 'price_in_oere';
