import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/security/get_device_id.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:app/core/security/jwt_storage.dart';

final dio = Dio();

Future<bool> refreshAccessToken() async {
  try {
    final refreshToken = await getRefreshToken();
    print(refreshToken);
    if (refreshToken == null) return false;

    final response = await dio.post(
      '$kBackendUrl/auth/refresh-token',
      data: {'token': refreshToken},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'audience': await getDeviceId(),
        },
      ),
    );

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
  } on DioException catch (e) {
    if (e.response != null) {
      throw ServerFailure(
          errorMessage: e.response?.data?['message'] ?? "",
          statusCode: e.response?.statusCode);
    } else {
      await deleteAccessToken();
      await deleteRefreshToken();
      return false;
    }
  } catch (e) {
    await deleteAccessToken();
    await deleteRefreshToken();
    return false;
  }
}
