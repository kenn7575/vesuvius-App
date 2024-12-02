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
  final List<CreateOrderItemParams> menuItems;
  final List<CreateOrderTableParams> tables;
  CreateOrderParams({
    this.waiterId,
    required this.menuItems,
    required this.tables,
  });
}

class CreateOrderItemParams {
  int menuItemId;
  int count;
  String? comment;
  CreateOrderItemParams({
    required this.menuItemId,
    required this.count,
    this.comment,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateOrderItemParams) return false;
    return other.menuItemId == menuItemId &&
        other.count == count &&
        other.comment == comment;
  }

  @override
  int get hashCode => Object.hash(menuItemId, count, comment);
}

class CreateOrderTableParams {
  final int tableId;
  const CreateOrderTableParams({
    required this.tableId,
  });
}
