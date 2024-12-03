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
