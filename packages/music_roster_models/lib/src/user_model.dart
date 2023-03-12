import 'user_role.dart';

class UserModelKey {
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String roles = 'roles';
}

class UserModel {
  final String uid;
  String name;
  String email;
  String phone;
  String? imageUrl;
  List<UserRole> roles;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.imageUrl,
    required this.roles,
  });

  static UserModel get emptyUser =>
      UserModel(uid: '', name: '', roles: [], email: '', phone: '');

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    List<UserRole> roles = [];

    (json[UserModelKey.roles] as List<dynamic>).forEach((element) {
      final role = UserRole.getUserRoleFromString(element as String);
      if (role != null) {
        roles.add(role);
      }
    });

    return UserModel(
        uid: id,
        name: json[UserModelKey.name],
        email: json[UserModelKey.email],
        phone: json[UserModelKey.phone],
        roles: roles);
  }

  Map<String, dynamic> get toJson {
    return {
      UserModelKey.name: name,
      UserModelKey.email: email,
      UserModelKey.phone: phone,
      UserModelKey.roles: roles.map((e) => e.key).toList(),
    };
  }
}
