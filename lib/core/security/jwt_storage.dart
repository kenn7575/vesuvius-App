import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

// Refresh token
Future<void> saveRefreshToken(String refreshToken) async {
  await storage.write(key: "refreshToken", value: refreshToken);
}

Future<String?> getRefreshToken() async =>
    await storage.read(key: 'refreshToken');

Future<void> deleteRefreshToken() async {
  await storage.delete(key: 'refreshToken');
}

// Access token
Future<void> saveAccessTokens(String accessToken) async {
  await storage.write(key: 'accessToken', value: accessToken);
}

Future<String?> getAccessToken() async =>
    await storage.read(key: 'accessToken');

Future<void> deleteAccessToken() async {
  await storage.delete(key: 'accessToken');
}
