import 'package:app/features/user/data/models/login_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../../business/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LoginUserModel>> loginUser(
      {required LoginUserParams loginUserParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        LoginUserModel remoteUser =
            await remoteDataSource.loginUser(loginUserParams: loginUserParams);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    if (await networkInfo.isConnected!) {
      try {
        UserModel remoteUser = await remoteDataSource.getUser();

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'No internet connection'));
    }
  }
}
