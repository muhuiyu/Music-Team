import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_team_admin/models/common/screen_name.dart';
import 'package:music_roster_models/music_roster_models.dart';

class Routes {
  Routes._();

  static String loginScreen = ScreenName.login.route;
  static String dashboardScreen = ScreenName.dashboard.route;
  static String manageMembersScreen = ScreenName.manageMembers.route;
  static String plannerScreen = ScreenName.planner.route;
  static String availabilityScreen = ScreenName.availability.route;
  static String songLibraryScreen = ScreenName.songLibrary.route;
  static String accountScreen = ScreenName.account.route;
  static String notificationsScreen = ScreenName.notifications.route;

  // Routes
  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => ScreenName.login.widget,
    dashboardScreen: (BuildContext context) => ScreenName.dashboard.widget,
    manageMembersScreen: (BuildContext context) =>
        ScreenName.manageMembers.widget,
    plannerScreen: (BuildContext context) => ScreenName.planner.widget,
    availabilityScreen: (BuildContext context) =>
        ScreenName.availability.widget,
    songLibraryScreen: (BuildContext context) => ScreenName.songLibrary.widget,
    accountScreen: (BuildContext context) => ScreenName.account.widget,
    notificationsScreen: (BuildContext context) =>
        ScreenName.notifications.widget,
  };

  static Map<String, dynamic> accountArgument(User user) {
    return {RoutesArgumentKey.user: user};
  }

  static Map<String, dynamic> serviceDetailsArgument(
      ServiceModel serviceModel) {
    return {RoutesArgumentKey.serviceModel: serviceModel};
  }

  static Map<String, dynamic> editMemberArgument(UserModel user) {
    return {RoutesArgumentKey.user: user};
  }
}

class RoutesArgumentKey {
  static const String user = 'user';
  static const String yearQuarter = 'yearQuarter';
  static const String serviceModel = 'serviceModel';
}
