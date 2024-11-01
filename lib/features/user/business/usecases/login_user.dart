import 'package:dartz/dartz.dart';

import 'package:app/core/errors/failure.dart';

import 'package:app/core/params/params.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class LoginUser {
  final UserRepository userRepository;

  LoginUser({required this.userRepository});

  Future<Either<Failure, UserEntity>> call({
    required LoginUserParams loginUserParams,
  }) async {
    return await userRepository.loginUser(loginUserParams: loginUserParams);
  }
}
