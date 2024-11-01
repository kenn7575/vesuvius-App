import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import '../../../../../../core/connection/network_info.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/params/params.dart';
import '../../business/entities/user_entity.dart';
import '../../business/usecases/login_user.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? user;
  Failure? failure;

  UserProvider({
    this.user,
    this.failure,
  });
  //functions to sign in and sign out

  void eitherFailureOrUser() async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrUser = await LoginUser(userRepository: repository).call(
      loginUserParams: const LoginUserParams(email: "s", password: "pss"),
    );

    failureOrUser.fold(
      (Failure newFailure) {
        user = null;
        failure = newFailure;
        notifyListeners();
      },
      (UserEntity newUser) {
        user = newUser;
        failure = null;
        notifyListeners();
      },
    );
  }
}
