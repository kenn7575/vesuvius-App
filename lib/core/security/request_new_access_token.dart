import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:app/core/security/jwt_storage.dart';

final dio = Dio();

Future<bool> refreshAccessToken() async {
  final refreshToken = await getRefreshToken();
  if (refreshToken == null) return false;

  final response = await dio.post(
    'http://localhost:5005/auth/refresh_token',
    data: {'token': refreshToken},
    options: Options(
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  // body: jsonEncode({'refreshToken': refreshToken}),
  // headers: {'Content-Type': 'application/json'},

  if (response.statusCode == 200) {
    final data = jsonDecode(response.data);
    await saveAccessTokens(data['accessToken']);
    await saveRefreshToken(data['refreshToken']);
    return true;
  } else {
    await deleteAccessToken();
    await deleteRefreshToken();
    return false;
  }
}
