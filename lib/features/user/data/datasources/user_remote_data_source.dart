import 'package:dio/dio.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/params/params.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> loginUser({required LoginUserParams loginUserParams});
  Future<UserModel> logoutUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> loginUser(
      {required LoginUserParams loginUserParams}) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon/',
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> logoutUser() async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon/',
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
