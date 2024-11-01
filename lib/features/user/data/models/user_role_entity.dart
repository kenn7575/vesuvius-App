import '../../business/entities/user_role_entity.dart';

class UserRoleModel extends UserRoleEntity {
  const UserRoleModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserRoleModel.fromJson({required Map<String, dynamic> json}) {
    return UserRoleModel(
      id: json[kId],
      name: json[kName],
      createdAt: json[kCreatedAt],
      updatedAt: json[kUpdatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kName: name,
      kCreatedAt: createdAt,
      kUpdatedAt: updatedAt,
    };
  }
}

// constants
// these constants are used to map the json data to the model and vice versa
String kId = 'id';
String kName = 'name';
String kCreatedAt = 'created_at';
String kUpdatedAt = 'updated_at';
