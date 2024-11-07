import '../../business/entities/user_entity.dart';

class LoginUserModel extends UserEntity {
  const LoginUserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
    super.accessToken,
    super.refreshToken,
  });

  factory LoginUserModel.fromJson({required Map<String, dynamic> json}) {
    final userJson = json[kUserObject];
    return LoginUserModel(
      id: userJson[kId],
      firstName: userJson[kFirstName],
      lastName: userJson[kLastName],
      email: userJson[kEmail],
      phoneNumber: userJson[kPhoneNumber],
      role: userJson[kRole],
      createdAt: userJson[kCreatedAt],
      updatedAt: userJson[kUpdatedAt],
      accessToken: json[kAccessToken],
      refreshToken: json[kRefreshToken],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kUserObject: {
        kId: id,
        kFirstName: firstName,
        kLastName: lastName,
        kEmail: email,
        kPhoneNumber: phoneNumber,
        kRole: role,
        kCreatedAt: createdAt,
        kUpdatedAt: updatedAt,
      },
      kAccessToken: accessToken,
      kRefreshToken: refreshToken,
    };
  }
}

// constants
// these constants are used to map the json data to the model and vice versa
String kUserObject = 'user';

String kId = 'id';
String kFirstName = 'first_name';
String kLastName = 'last_name';
String kEmail = 'email';
String kPhoneNumber = 'phone_number';
String kRole = 'role_id';
String kCreatedAt = 'created_at';
String kUpdatedAt = 'updated_at';

String kAccessToken = 'accessToken';
String kRefreshToken = 'refreshToken';
