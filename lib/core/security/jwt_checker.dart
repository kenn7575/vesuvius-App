import 'package:jwt_decode/jwt_decode.dart';

bool isTokenExpired(String token) {
  return Jwt.isExpired(token);
}
