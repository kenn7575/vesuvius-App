import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/security/authenticated_dio_client.dart';
import 'package:app/core/security/get_device_id.dart';
import 'package:app/features/user/data/models/login_user_model.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/params/params.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<LoginUserModel> loginUser({required LoginUserParams loginUserParams});
  Future<UserModel> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  final AuthenticatedDioClient authenticatedDioClient;

  UserRemoteDataSourceImpl({
    required this.dio,
    required this.authenticatedDioClient,
  });

  @override
  Future<LoginUserModel> loginUser(
      {required LoginUserParams loginUserParams}) async {
    try {
      String deviceId = await getDeviceId();

      final response = await dio.post(
        ('$kBackendUrl/auth/signin'),
        data: {
          'email': loginUserParams.email,
          'password': loginUserParams.password,
        },
        options: Options(
          headers: {
            'audience': deviceId,
          },
        ),
      );

      return LoginUserModel.fromJson(json: response.data);
    } on DioException catch (e) {
      // something went wrong with the request
      final message =
          e.response?.data is Map ? e.response?.data['message'] : null;
      final fieldErrors =
          e.response?.data is Map ? e.response?.data['fieldErrors'] : null;

      if (fieldErrors != null) {
        //there was a validation error
        throw ValidationFailure(
          fieldErrors: (fieldErrors as Map<String, dynamic>).map(
            (key, value) => MapEntry(
              key,
              (value as List).map((e) => e.toString()).toList(),
            ),
          ),
          errorMessage: message ?? 'A validation error occurred',
        );
      } else {
        // there was an error message
        throw ServerFailure(
          errorMessage: message ?? 'An error occurred',
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      //something else went wrong
      throw ServerFailure(errorMessage: "Unknown error occurred");
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final client = authenticatedDioClient.client;
      final response = await client.get('$kBackendUrl/user');

      if (response.statusCode == 200) {
        return UserModel.fromJson(json: response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerFailure(
            errorMessage: e.response?.data?['message'] ?? "",
            statusCode: e.response?.statusCode);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
