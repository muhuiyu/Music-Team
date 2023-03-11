import 'package:flutter/material.dart';
import 'package:music_team_mobile/api/mock_data.dart';
import 'package:music_team_mobile/base/base_provider.dart';
import 'package:music_team_mobile/api/network/endpoints.dart';
import 'package:music_team_mobile/models/notifications/team_notification.dart';

class DataProvider extends BaseProvider {
  // static const numberOfEntriesPerPage = 10;

  // Future<User?> getUser() async {
  //   // TODO: add real data
  //   await fetchAllUsers().then((value) {
  //     return value.first;
  //   });
  // }

  // /// Returns latest version of kpis in the given quarter of current user
  // Future<KpiDetails> fetchLatestKpiOfCurrentUser(
  //     YearQuarter yearQuarter) async {
  //   if (pref.userId == null) {
  //     throw AppError(AppError.missingUserId);
  //   }
  //   return fetchLatestKpi(pref.userId!, yearQuarter);
  // }

  // /// Returns latest version of kpis in the given quarter
  // Future<KpiDetails> fetchLatestKpi(int userId, YearQuarter yearQuarter) async {
  //   try {
  //     showLoadingIndicator();
  //     var details = await _fetchKpiDetails(userId, yearQuarter);
  //     hideLoadingIndicator();
  //     return details;
  //   } on DioError {
  //     hideLoadingIndicator();
  //     rethrow;
  //   }
  // }

  // Future<List<KpiDetails>> fetchKpiHistory(YearQuarter yearQuarter) async {
  //   try {
  //     if (pref.userId == null) {
  //       throw AppError(AppError.missingUserId);
  //     }
  //     showLoadingIndicator();
  //     final kpisResponse = await dioClient.get(
  //       Endpoints.baseUrl! + Endpoints.userKpiHistory,
  //       queryParameters:
  //           DataProvider.kpisHistoryRequestBody(pref.userId!, yearQuarter),
  //     );

  //     hideLoadingIndicator();
  //     return KpiDetails.parseKpisHistoryFromJson(kpisResponse);
  //   } on DioError {
  //     hideLoadingIndicator();
  //     rethrow;
  //   }
  // }

  // // Returns users as List<User> and kpiDetails as Map<int, KpiGroup>
  // Future<Map<String, dynamic>> fetchUsersAndDetails(
  //     FetchDataScope scope) async {
  //   try {
  //     showLoadingIndicator();
  //     // 1. get users / team members
  //     final usersResponse = await dioClient.post(
  //       Endpoints.baseUrl! + Endpoints.users,
  //       // TODO: add pagination
  //       data: jsonEncode(DataProvider.usersRequestBody(scope, 1)),
  //     );
  //     final users = (usersResponse[DataProviderKey.data] as List<dynamic>)
  //         .map((e) => User.fromJson(e))
  //         .toList();

  //     // 2. get kpis
  //     Map<int, KpiDetails> kpiDetails = {};
  //     for (var user in users) {
  //       await _fetchKpiDetails(user.id, YearQuarter.current()).then((value) {
  //         kpiDetails[user.id] = value;
  //       });
  //     }
  //     hideLoadingIndicator();
  //     return {
  //       DataProviderKey.users: users,
  //       DataProviderKey.kpiDetails: kpiDetails
  //     };
  //   } on DioError {
  //     hideLoadingIndicator();
  //     rethrow;
  //   }
  // }

  // /// Returns list of all active users
  // Future<List<User>> fetchAllUsers() async {
  //   try {
  //     showLoadingIndicator();
  //     final response = await dioClient.post(
  //       Endpoints.baseUrl! + Endpoints.users,
  //       // TODO: add pagination
  //       data: jsonEncode(DataProvider.usersRequestBody(FetchDataScope.all, 1)),
  //     );

  //     hideLoadingIndicator();
  //     return (response[DataProviderKey.data] as List<dynamic>)
  //         .map((e) => User.fromJson(e))
  //         .toList();
  //   } on DioError {
  //     hideLoadingIndicator();
  //     rethrow;
  //   }
  // }

  // /// Returns list of available roles
  // Future<List<EmployeeRole>> fetchRoleList() async {
  //   return Future(() => [EmployeeRole.admin, EmployeeRole.manager]);
  // }

  // Future<List<User>> fetchManagerList() async {
  //   // TODO: add real data
  //   // return Future(() => [
  //   //       User(id: 'manager-1', name: 'Smith Willson'),
  //   //       User(id: 'manager-2', name: 'Ayon Kim'),
  //   //     ]);
  //   return fetchAllUsers();
  // }

  // /// Updates kpi score
  // Future<bool> updateScore(String kpiId, YearQuarter yearQuarter,
  //     YearMonthWeek yearMonthWeek, KpiStatus kpiStatus) async {
  //   try {
  //     if (pref.userId == null) {
  //       throw AppError(AppError.missingUserId);
  //     }
  //     if (!kpiStatus.isScored) {
  //       return false;
  //     }
  //     showLoadingIndicator();
  //     final response = await dioClient.post(
  //       Endpoints.baseUrl! + Endpoints.userUpdateScore,
  //       data: jsonEncode(DataProvider.updateScoreRequestBody(
  //           pref.userId!, kpiId, yearQuarter, yearMonthWeek, kpiStatus)),
  //     );

  //     hideLoadingIndicator();
  //     return response[DataProviderKey.success];
  //   } on DioError {
  //     hideLoadingIndicator();
  //     rethrow;
  //   }
  // }

  // /// Update kpi descriptions
  // Future<bool> updateKpis(
  //     int userId, YearQuarter yearQuarter, List<String> kpis) async {
  //   try {
  //     // TODO: use real data
  //     if (kpis.length != KpiDetails.numberOfKpis) {
  //       return false;
  //     }
  //     showLoadingIndicator();
  //     final response = await dioClient.post(
  //       Endpoints.baseUrl! + Endpoints.userUpdateKpis,
  //       data: jsonEncode(
  //           DataProvider.updateKpisRequestBody(userId, yearQuarter, kpis)),
  //     );
  //     hideLoadingIndicator();
  //     return response[DataProviderKey.success];
  //   } on DioError {
  //     hideLoadingIndicator();
  //     rethrow;
  //   }
  // }

  // // Request Body
  // static Map<String, dynamic> usersRequestBody(
  //     FetchDataScope scope, int pageNumber) {
  //   // TODO: change to team member only for different scopes
  //   return {
  //     DataProviderKey.limit: DataProvider.numberOfEntriesPerPage,
  //     DataProviderKey.pageNumber: pageNumber,
  //   };
  // }

  // static Map<String, dynamic> kpisRequestBody(
  //     int userId, YearQuarter yearQuarter) {
  //   return {
  //     DataProviderKey.employeeId: userId,
  //     DataProviderKey.scoreYear: yearQuarter.year,
  //     DataProviderKey.scoreQuarter: yearQuarter.quarter,
  //   };
  // }

  // static Map<String, dynamic> kpisHistoryRequestBody(
  //     int userId, YearQuarter yearQuarter) {
  //   return {
  //     DataProviderKey.employeeId: userId,
  //     DataProviderKey.scoreYear: yearQuarter.year,
  //     DataProviderKey.scoreQuarter: yearQuarter.quarter,
  //   };
  // }

  // static Map<String, dynamic> updateScoreRequestBody(
  //   int userId,
  //   String kpiId,
  //   YearQuarter yearQuarter,
  //   YearMonthWeek yearMonthWeek,
  //   KpiStatus kpiStatus,
  // ) {
  //   return {
  //     DataProviderKey.employeeId: userId,
  //     DataProviderKey.scoreYear: yearQuarter.year,
  //     DataProviderKey.scoreQuarter: yearQuarter.quarter,
  //     DataProviderKey.scoreWeek: yearMonthWeek.formattedString,
  //     DataProviderKey.scoreValue: kpiStatus.code,
  //     DataProviderKey.kpiId: kpiId
  //   };
  // }

  // static Map<String, dynamic> updateKpisRequestBody(
  //     int userId, YearQuarter yearQuarter, List<String> kpis) {
  //   // TODO:
  //   return {};
  // }

  // // Private functions
  // Future<KpiDetails> _fetchKpiDetails(
  //     int userId, YearQuarter yearQuarter) async {
  //   final kpisResponse = await dioClient.get(
  //     Endpoints.baseUrl! + Endpoints.userKpis,
  //     queryParameters: DataProvider.kpisRequestBody(userId, yearQuarter),
  //   );
  //   return Future(() => KpiDetails.fromJson(kpisResponse));
  // }

  Future<List<TeamNotification>> fetchNotifications() {
    // TODO: change to real data
    return Future(() => notificationsTestEntries);
  }
}

class DataProviderKey {
  static const songs = 'songs';
  static const members = 'members';
  static const date = 'date';
  static const year = 'year';
  static const month = 'month';
  static const monthGroup = 'monthGroup';
  static const day = 'day';
  static const rehearsalDates = 'rehearsalDates';

  static const songId = 'songId';
  static const songName = 'songName';
  static const note = 'note';

  static const data = 'data';
  static const success = 'success';
  static const users = 'users';
  static const name = 'name';
  static const phone = 'phone';
  static const email = 'email';
  static const roles = 'roles';
  static const description = 'description';
  static const version = 'version';
  static const effectiveDate = 'effectiveDate';
  static const createdDate = 'createdDate';
  static const updatedDate = 'updatedDate';
  static const limit = 'limit';
  static const isActive = 'isActive';
  static const pageNumber = 'pageNumber';
}
