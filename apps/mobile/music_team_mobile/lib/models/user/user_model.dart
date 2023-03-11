import 'package:music_team_mobile/models/user/user_role.dart';

class UserModel {
  final String uid;
  String name;
  String email;
  String? phoneNumber;
  String? photoUrl;
  List<UserRole> roles;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.photoUrl,
    required this.roles,
  });
}
