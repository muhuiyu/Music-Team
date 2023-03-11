import 'package:music_roster_admin/api/providers/data_provider.dart';
import 'package:music_roster_admin/models/user/user_role.dart';

class UserModel {
  final String uid;
  String name;
  String email;
  String phone;
  // String? imageUrl;
  List<UserRole> roles;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    // this.imageUrl,
    required this.roles,
  });

  static UserModel get emptyUser =>
      UserModel(uid: '', name: '', roles: [], email: '', phone: '');

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    List<UserRole> roles = [];

    (json[DataProviderKey.roles] as List<dynamic>).forEach((element) {
      final role = UserRole.getUserRoleFromString(element as String);
      if (role != null) {
        roles.add(role);
      }
    });

    return UserModel(
        uid: id,
        name: json[DataProviderKey.name],
        email: json[DataProviderKey.email],
        phone: json[DataProviderKey.phone],
        roles: roles);
  }

  Map<String, dynamic> get toJson {
    return {
      DataProviderKey.name: name,
      DataProviderKey.email: email,
      DataProviderKey.phone: phone,
      DataProviderKey.roles: roles.map((e) => e.key).toList(),
    };
  }
}
