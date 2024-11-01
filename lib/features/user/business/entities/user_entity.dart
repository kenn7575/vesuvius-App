import 'package:app/features/user/business/entities/user_role_entity.dart';

class UserEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final UserRoleEntity role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
}
