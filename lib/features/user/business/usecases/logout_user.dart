import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class LogoutUser {
  final UserRepository userRepository;

  LogoutUser({required this.userRepository});

  Future<Either<Failure, UserEntity>> call() async {
    return await userRepository.logoutUser();
  }
}
