import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import 'package:app/features/user/business/repositories/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../datasources/token_local_datasource.dart';
import '../datasources/token_remote_datasource.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenLocalDataSource localDataSource;
  final TokenRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TokenRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> initUserSession() async {
    final accessToken = await localDataSource.getAccessToken();
    final refreshToken = await localDataSource.getRefreshToken();

    // fail fast
    if (accessToken == null || refreshToken == null) {
      return Left(ServerFailure(errorMessage: 'No tokens found'));
    }

    if (Jwt.isExpired(accessToken)) {
      try {
        await refreshAccessToken();
        return const Right(null);
      } catch (e) {
        return Left(
            ServerFailure(errorMessage: 'Failed to refresh access token'));
      }
    } else {
      return const Right(null);
    }
  }

  @override
  Future<String?> getAccessToken() => localDataSource.getAccessToken();

  @override
  Future<String?> getRefreshToken() => localDataSource.getRefreshToken();

  @override
  bool isTokenExpired({required IsTokenExpiredParams isTokenExpiredParams}) =>
      Jwt.isExpired(isTokenExpiredParams.token);

  @override
  Future<Either<Failure, Null>> refreshAccessToken() async {
    if (await networkInfo.isConnected!) {
      try {
        final refreshToken = await localDataSource.getRefreshToken();
        if (refreshToken == null) {
          return Left(ServerFailure(errorMessage: 'No refresh token found'));
        }

        final newAccessToken =
            await remoteDataSource.fetchNewAccessToken(refreshToken);
        await localDataSource.saveAccessToken(newAccessToken);

        return const Right(null);
      } on ServerFailure catch (e) {
        // the server did not return a 2xx status code
        return Left(e);
      } catch (e) {
        // unknown exception
        return Left(
          ServerFailure(errorMessage: 'An error occurred'),
        );
      }
    } else {
      // no internet connection
      return Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<void> clearTokens() => localDataSource.clearTokens();
}
