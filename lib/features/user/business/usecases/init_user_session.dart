import 'package:app/features/user/business/repositories/token_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:app/core/errors/failure.dart';

class InitUserSession {
  final TokenRepository tokenRepository;

  InitUserSession({required this.tokenRepository});

  Future<Either<Failure, void>> call() async {
    return await tokenRepository.initUserSession();
  }
}
