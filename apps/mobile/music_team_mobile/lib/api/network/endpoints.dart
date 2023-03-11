import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  Endpoints._();
  static String? baseUrl = dotenv.env['BASE_URL'];
  // receiveTimeout
  static const Duration receiveTimeout =
      Duration(hours: 0, minutes: 0, seconds: 15);
  // connectTimeout
  static const Duration connectionTimeout =
      Duration(hours: 2, minutes: 3, seconds: 30);
  // login
  static const String authLogin = '/api/auth/login';
  // get user kpi
  static const String userKpis = '/v1/user/kpis';
  // get user kpi history
  static const String userKpiHistory = '/v1/user/kpisHistory';
  // get all users
  static const String users = '/v1/users';
  // update score
  static const String userUpdateScore = '/v1/user/updateScore';
  // update kpis
  static const String userUpdateKpis = '/v1/user/updateKpis';
}
