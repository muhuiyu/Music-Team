import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/modules/account/account_screen.dart';
import 'package:music_team_admin/modules/auth/login_screen.dart';
import 'package:music_team_admin/modules/availability/availability_screen.dart';
import 'package:music_team_admin/modules/common/widgets/custom_page.dart';
import 'package:music_team_admin/modules/dashboard/dashboard_screen.dart';
import 'package:music_team_admin/modules/manage_members/screens/manage_members_screen.dart';
import 'package:music_team_admin/modules/planner/screens/planner_screen.dart';
import 'package:music_team_admin/modules/service_model/service_details_screen.dart';
import 'package:music_team_admin/modules/notifications/notifications_screen.dart';
import 'package:music_team_admin/modules/song_library/song_library_screen.dart';

enum ScreenName {
  login,
  dashboard,
  planner,
  manageMembers,
  serviceDetails,
  songLibrary,
  notifications,
  availability,
  account;

  static ScreenName? fromString(String rawString) {
    for (var value in ScreenName.values) {
      if (value.id == rawString) return value;
    }
    return null;
  }
}

extension AppPageTypeExtension on ScreenName {
  String get route {
    return '/$id';
  }

  bool get isRoot {
    var pagesAreRoot = [
      ScreenName.dashboard,
      ScreenName.planner,
      ScreenName.availability,
      ScreenName.songLibrary,
      ScreenName.account,
    ];
    return pagesAreRoot.contains(this);
  }

  CustomPageAction? get action {
    switch (this) {
      case ScreenName.login:
        return null;
      case ScreenName.dashboard:
        return null;
      case ScreenName.planner:
        return null;
      case ScreenName.manageMembers:
        return null;
      case ScreenName.songLibrary:
        return null;
      case ScreenName.serviceDetails:
        return null;
      case ScreenName.notifications:
        return null;
      case ScreenName.availability:
        return null;
      case ScreenName.account:
        return null;
    }
  }

  Widget get widget {
    switch (this) {
      case ScreenName.login:
        return LoginScreen();
      case ScreenName.dashboard:
        return DashboardScreen();
      case ScreenName.planner:
        return PlannerScreen();
      case ScreenName.manageMembers:
        return ManageMembersScreen();
      case ScreenName.songLibrary:
        return SongLibraryScreen();
      case ScreenName.serviceDetails:
        return ServiceDetailsScreen();
      case ScreenName.notifications:
        return NotificationsScreen();
      case ScreenName.availability:
        return AvailabilityScreen();
      case ScreenName.account:
        return AccountScreen();
    }
  }

  CustomPageType get pageType {
    switch (this) {
      case ScreenName.login:
        return CustomPageType.root;
      case ScreenName.dashboard:
        return CustomPageType.root;
      case ScreenName.planner:
        return CustomPageType.root;
      case ScreenName.manageMembers:
        return CustomPageType.root;
      case ScreenName.songLibrary:
        return CustomPageType.root;
      case ScreenName.serviceDetails:
        return CustomPageType.sub;
      case ScreenName.notifications:
        return CustomPageType.modal;
      case ScreenName.availability:
        return CustomPageType.root;
      case ScreenName.account:
        return CustomPageType.root;
    }
  }

  Color get appBarBackgroundColor {
    switch (this) {
      case ScreenName.login:
        return AppColors.white;
      case ScreenName.dashboard:
        return AppColors.primary;
      case ScreenName.planner:
        return AppColors.primary;
      case ScreenName.manageMembers:
        return AppColors.primary;
      case ScreenName.songLibrary:
        return AppColors.primary;
      case ScreenName.serviceDetails:
        return AppColors.white;
      case ScreenName.notifications:
        return AppColors.white;
      case ScreenName.availability:
        return AppColors.primary;
      case ScreenName.account:
        return AppColors.primary;
    }
  }

  String getIconName(bool isActive) {
    // switch (this) {
    //   case ScreenName.weeklyKpi:
    //     return isActive ? AppImage.weeklyKpiBlack : AppImage.weeklyKpiWhite;
    //   case ScreenName.report:
    //     return isActive ? AppImage.reportBlack : AppImage.reportWhite;
    //   case ScreenName.settings:
    //     return isActive ? AppImage.settingsBlack : AppImage.settingsWhite;
    //   default:
    //     return '';
    // }
    return '';
  }

  bool get hasIcon {
    return getIconData(true) != null;
  }

  IconData? getIconData(bool isActive) {
    switch (this) {
      case ScreenName.login:
        return null;
      case ScreenName.dashboard:
        return Icons.dashboard;
      case ScreenName.planner:
        return Icons.calendar_month;
      case ScreenName.manageMembers:
        return Icons.people;
      case ScreenName.songLibrary:
        return Icons.music_note;
      case ScreenName.serviceDetails:
        return null;
      case ScreenName.notifications:
        return Icons.notifications;
      case ScreenName.availability:
        return Icons.people;
      case ScreenName.account:
        return Icons.person;
    }
  }

  String get id {
    return toString().split('.').last;
  }

  String get name {
    switch (this) {
      case ScreenName.login:
        return AppText.login;
      case ScreenName.dashboard:
        return AppText.dashboardTitle;
      case ScreenName.planner:
        return AppText.plannerTitle;
      case ScreenName.manageMembers:
        return AppText.manageMembersTitle;
      case ScreenName.songLibrary:
        return AppText.songLibraryTitle;
      case ScreenName.serviceDetails:
        return AppText.eventDetailsTitle;
      case ScreenName.notifications:
        return AppText.notificationTitle;
      case ScreenName.availability:
        return AppText.availabilityTitle;
      case ScreenName.account:
        return AppText.accountTitle;
    }
  }
}

enum CustomPageAction { save, notification }

// class AppScreen {
//   static final kpiPage = KpiPageRoute(); // TODO: change to const
//   static EditEmployeePageRoute editEmployeePage({required Employee employee}) {
//     return EditEmployeePageRoute(employee: employee);
//   }
// }

// class EditEmployeePageRoute extends AppRoute {
//   Employee employee;
//   EditEmployeePageRoute({required this.employee})
//       : super(name: AppPageName.editEmployee);
// }

// class KpiPageRoute extends AppRoute {
//   KpiPageRoute() : super(name: AppPageName.weeklyKpi);
// }

// abstract class AppRoute {
//   final AppPageName name;
//   AppRoute({required this.name});
// }
