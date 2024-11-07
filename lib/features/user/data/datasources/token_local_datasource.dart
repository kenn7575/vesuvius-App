import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenLocalDataSource {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<void> clearTokens();
}

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final storage = const FlutterSecureStorage();

  @override
  Future<String?> getAccessToken() => storage.read(key: 'accessToken');
  @override
  Future<String?> getRefreshToken() => storage.read(key: 'refreshToken');

  @override
  Future<void> saveAccessToken(String token) =>
      storage.write(key: 'accessToken', value: token);

  @override
  Future<void> saveRefreshToken(String token) =>
      storage.write(key: 'refreshToken', value: token);

  @override
  Future<void> clearTokens() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
  }
}
