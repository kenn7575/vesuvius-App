import 'package:app/core/security/authenticated_dio_client.dart';
import 'package:app/core/security/jwt_storage.dart';
import 'package:app/features/user/business/usecases/get_user.dart';
import 'package:app/features/user/business/usecases/init_user_session.dart';
import 'package:app/features/user/data/datasources/token_local_datasource.dart';
import 'package:app/features/user/data/datasources/token_remote_datasource.dart';
import 'package:app/features/user/data/repositories/token_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../../business/entities/user_entity.dart';
import '../../business/usecases/login_user.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? user;
  Failure? failure;
  final AuthenticatedDioClient authenticatedDioClient =
      AuthenticatedDioClient();

  UserProvider({
    this.user,
    this.failure,
  }) {
    authenticatedDioClient.isAuthenticated.addListener(() {
      if (!authenticatedDioClient.isAuthenticated.value) {
        signout();
      }
    });

    initUser();
  }
  Future<void> initUser() async {
    TokenRepositoryImpl repository = TokenRepositoryImpl(
      localDataSource: TokenLocalDataSourceImpl(),
      remoteDataSource: TokenRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrVoid =
        await InitUserSession(tokenRepository: repository).call();

    failureOrVoid.fold(
      (Failure newFailure) {
        user = null;
        failure = newFailure;
        notifyListeners();
      },
      (void _) {
        eitherFailureOrUser();
      },
    );
  }

  //functions to sign in and sign out
  void eitherFailureOrLogin({
    required String email,
    required String password,
  }) async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrUser = await LoginUser(userRepository: repository).call(
      loginUserParams: LoginUserParams(email: email, password: password),
    );

    failureOrUser.fold(
      (Failure newFailure) {
        user = null;
        failure = newFailure;
        notifyListeners();
      },
      (UserEntity newUser) {
        if (newUser.accessToken != null && newUser.refreshToken != null) {
          saveAccessTokens(newUser.accessToken!);
          saveRefreshToken(newUser.refreshToken!);
          user = newUser;
          failure = null;
        } else {
          user = null;
          failure = ServerFailure(errorMessage: 'No tokens found');
          deleteAccessToken();
          deleteRefreshToken();
        }
        // TODO: redundand code?

        notifyListeners();
      },
    );
  }

  void signout() {
    // Add your signout logic here
    user = null;
    failure = null;
    deleteAccessToken();
    deleteRefreshToken();

    notifyListeners();
  }

  void eitherFailureOrUser() async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrUser = await GetUser(userRepository: repository).call();

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
