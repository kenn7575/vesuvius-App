import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/security/get_device_id.dart';
import 'package:app/features/user/data/models/access_toke_model.dart';
import 'package:dio/dio.dart';

abstract class TokenRemoteDataSource {
  Future<String> fetchNewAccessToken(String refreshToken);
}

class TokenRemoteDataSourceImpl implements TokenRemoteDataSource {
  final Dio dio;

  TokenRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> fetchNewAccessToken(String refreshToken) async {
    try {
      final response = await dio.post(
        'http://localhost:5005/auth/refresh-token',
        data: {'token': refreshToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'audience': await getDeviceId(),
          },
        ),
      );
      return AccessTokenModel.fromJson(json: response.data).accessToken;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerFailure(
            errorMessage: e.response?.data['message'] ?? "",
            statusCode: e.response?.statusCode);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
