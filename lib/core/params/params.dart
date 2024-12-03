class NoParams {}

class TemplateParams {}

class PokemonParams {
  final String id;
  const PokemonParams({
    required this.id,
  });
}

class LoginUserParams {
  final String email;
  final String password;
  const LoginUserParams({
    required this.email,
    required this.password,
  });
}

class GetUserParams {
  final int id;
  const GetUserParams({
    required this.id,
  });
}

class PokemonImageParams {}

class IsTokenExpiredParams {
  final String token;
  const IsTokenExpiredParams({
    required this.token,
  });
}

class GetMenuItemsParams {
  final int typeId;
  const GetMenuItemsParams(
    this.typeId,
  );
}

//classes for creating new order with table and menu items
class CreateOrderParams {
  int? waiterId;
  String? comment;
  final List<CreateOrderItemParams> orderItems;
  final List<CreateOrderTableParams> orderTables;
  CreateOrderParams({
    this.waiterId,
    required this.orderItems,
    required this.orderTables,
    this.comment,
  });

  factory CreateOrderParams.fromJson({required Map<String, dynamic> json}) {
    return CreateOrderParams(
      waiterId: json[kWaiterId],
      comment: json[kComment],
      orderItems: CreateOrderItemParams.fromJsonList(json[kOrderItems]),
      orderTables: CreateOrderTableParams.fromJsonList(json[kOrderTables]),
    );
  }
  static List<CreateOrderParams> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CreateOrderParams.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<CreateOrderParams> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kComment: comment,
      kWaiterId: waiterId,
      kOrderItems: CreateOrderItemParams.toJsonList(
          orderItems.cast<CreateOrderItemParams>()),
      kOrderTables: CreateOrderTableParams.toJsonList(
          orderTables.cast<CreateOrderTableParams>()),
    };
  }
}

const String kComment = 'comment';
const String kWaiterId = 'waiter_id';
const String kOrderItems = 'order_items';
const String kOrderTables = 'order_tables';

class CreateOrderItemParams {
  int menuItemId;
  int quantity;
  String? comment;
  CreateOrderItemParams({
    required this.menuItemId,
    required this.quantity,
    this.comment,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateOrderItemParams) return false;
    return other.menuItemId == menuItemId &&
        other.quantity == quantity &&
        other.comment == comment;
  }

  @override
  int get hashCode => Object.hash(menuItemId, quantity, comment);

  factory CreateOrderItemParams.fromJson({required Map<String, dynamic> json}) {
    return CreateOrderItemParams(
      menuItemId: json[kMenuItemId],
      quantity: json[kQuantity],
      comment: json[kComment],
    );
  }

  static List<CreateOrderItemParams> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CreateOrderItemParams.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CreateOrderItemParams> models) {
    return models.map((model) => model.toJson()).toList();
  }

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

class CreateOrderTableParams {
  final int tableId;
  const CreateOrderTableParams({
    required this.tableId,
  });

  factory CreateOrderTableParams.fromJson(
      {required Map<String, dynamic> json}) {
    return CreateOrderTableParams(
      tableId: json[kTableId],
    );
  }

  static List<CreateOrderTableParams> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CreateOrderTableParams.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CreateOrderTableParams> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kTableId: tableId,
    };
  }
}

const String kTableId = 'table_id';
