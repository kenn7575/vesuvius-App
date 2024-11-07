import 'package:app/features/user/business/repositories/token_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:app/core/errors/failure.dart';

import 'package:app/core/params/params.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class InitUserSession {
  final TokenRepository tokenRepository;

  InitUserSession({required this.tokenRepository});

  Future<Either<Failure, void>> call() async {
    return await tokenRepository.initUserSession();
  }
}
