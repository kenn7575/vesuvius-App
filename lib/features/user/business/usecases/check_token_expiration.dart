import 'package:app/core/params/params.dart';
import 'package:app/features/user/business/repositories/token_repository.dart';

class CheckTokenExpiration {
  final TokenRepository tokenRepository;

  CheckTokenExpiration({required this.tokenRepository});

  bool call({required IsTokenExpiredParams isTokenExpiredParams}) {
    return tokenRepository.isTokenExpired(
        isTokenExpiredParams: isTokenExpiredParams);
  }
}
