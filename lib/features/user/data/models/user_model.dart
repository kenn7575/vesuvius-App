import '../../business/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      id: json[kId],
      firstName: json[kFirstName],
      lastName: json[kLastName],
      email: json[kEmail],
      phoneNumber: json[kPhoneNumber],
      role: json[kRole],
      createdAt: json[kCreatedAt],
      updatedAt: json[kUpdatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kFirstName: firstName,
      kLastName: lastName,
      kEmail: email,
      kPhoneNumber: phoneNumber,
      kRole: role,
      kCreatedAt: createdAt,
      kUpdatedAt: updatedAt,
    };
  }
}

// constants
// these constants are used to map the json data to the model and vice versa
String kId = 'id';
String kFirstName = 'first_name';
String kLastName = 'last_name';
String kEmail = 'email';
String kPhoneNumber = 'phone_number';
String kRole = 'role';
String kCreatedAt = 'created_at';
String kUpdatedAt = 'updated_at';
