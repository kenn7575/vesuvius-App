import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import 'package:dartz/dartz.dart';

abstract class TokenRepository {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<Either<Failure, Null>> refreshAccessToken();
  bool isTokenExpired({required IsTokenExpiredParams isTokenExpiredParams});
  Future<void> clearTokens();

  Future<Either<Failure, void>> initUserSession();
}
