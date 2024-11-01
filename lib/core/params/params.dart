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

class PokemonImageParams {}
