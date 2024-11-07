import 'package:app/features/user/business/entities/user_role_entity.dart';

class UserEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int role;
  final String createdAt;
  final String updatedAt;
  final String? accessToken;
  final String? refreshToken;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.accessToken,
    this.refreshToken,
  });
}
