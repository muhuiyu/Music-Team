import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_team_admin/api/mock_data.dart';
import 'package:music_team_admin/base/base_provider.dart';
import 'package:music_team_admin/helpers/app_message.dart';
import 'package:music_team_admin/models/common/year_month_day.dart';
import 'package:music_team_admin/models/notifications/team_notification.dart';
import 'package:music_team_admin/models/service/service_model.dart';
import 'package:music_team_admin/models/service/song.dart';
import 'package:music_team_admin/models/user/user_model.dart';
import 'package:music_team_admin/models/user/user_role.dart';

class DataProvider extends BaseProvider {
  static const numberOfEntriesPerPage = 10;
  CollectionReference servicesReference =
      FirebaseFirestore.instance.collection('services');
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');
  CollectionReference songsReference =
      FirebaseFirestore.instance.collection('songs');

  // TODO: add cache management
  Map<String, UserModel> usersCache = {};
  Map<String, Song> songCache = {};
  DateTime lastFetchedTimeOfUsers = DateTime.fromMicrosecondsSinceEpoch(0);
  DateTime lastFetchedTimeOfSongs = DateTime.fromMicrosecondsSinceEpoch(0);

  String getUserNameFromCache(String userId) {
    return usersCache[userId]?.name ?? '';
  }

  Future<List<ServiceModel>> fetchUpcomingServices(
      {int numberOfServices = 2}) async {
    final services = await fetchServices(YearMonthDay.now().year,
        YearMonthDay.now().month, YearMonthDay.now().month + 1);
    return services.sublist(0, numberOfServices).toList();
  }

  Future<List<ServiceModel>> fetchServices(
      int year, int startMonth, int endMonth) async {
    List<ServiceModel> services = [];
    try {
      fetchAllUsers();

      // Fetch records
      final querySnapshot = await servicesReference
          .where(DataProviderKey.year, isEqualTo: year)
          .where(DataProviderKey.monthGroup,
              isEqualTo: YearMonthDay.getMonthGroupOfMonth(startMonth))
          .get()
          .onError((error, stackTrace) {
        return AppMessage.errorMessage(error.toString());
      });

      for (var docSnapshot in querySnapshot.docs) {
        services.add(ServiceModel.fromJson(
            docSnapshot.data() as Map<String, dynamic>, usersCache));
      }

      // Add dates without records
      final sundays = YearMonthDay.getWeekdaysInMonths(
          DateTime.sunday, year, startMonth, endMonth);

      sundays
          .where((date) => !services.map((e) => e.date).contains(date))
          .forEach((date) {
        services.add(
            ServiceModel(date: date, duty: {}, songs: [], rehearsalDates: []));
      });

      services.sort();
      return services;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, Song>> fetchAllSongs() async {
    if (songCache.isNotEmpty) {
      return songCache;
    }
    try {
      final Map<String, Song> songMap = {};

      final snapshot = await songsReference
          .get()
          .then((value) => value)
          .onError(
              (error, stackTrace) => AppMessage.errorMessage(error.toString()));

      snapshot.docs.forEach((doc) {
        final Song song =
            Song.fromJson(doc.id, doc.data() as Map<String, dynamic>);
        songMap[song.id] = song;
      });

      songCache = songMap;
      return songMap;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, UserModel>> fetchAllUsers() async {
    if (usersCache.isNotEmpty) {
      return usersCache;
    }

    try {
      final Map<String, UserModel> userMap = {};

      final snapshot = await usersReference
          .get()
          .then((value) => value)
          .onError(
              (error, stackTrace) => AppMessage.errorMessage(error.toString()));

      snapshot.docs.forEach((doc) {
        final UserModel user =
            UserModel.fromJson(doc.id, doc.data() as Map<String, dynamic>);
        userMap[user.uid] = user;
      });

      usersCache = userMap;
      return userMap;
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel?> getUser() async {
    // TODO: add real data
    return testUsers[0];
  }

  /// Updates users for the given role on the given service date
  Future<bool> updateUsersForRoleOnServiceDate(
      ServiceModel serviceModel, UserRole role, List<UserModel> users) async {
    final Map<String, dynamic> data = {
      DataProviderKey.duty: serviceModel.dutyJson,
    };

    try {
      final documentId = await servicesReference
          .where(DataProviderKey.year, isEqualTo: serviceModel.date.year)
          .where(DataProviderKey.month, isEqualTo: serviceModel.date.month)
          .where(DataProviderKey.day, isEqualTo: serviceModel.date.day)
          .get()
          .then((value) => value.docChanges.first.doc.id)
          .onError(
              (error, stackTrace) => AppMessage.errorMessage(error.toString()));

      if (documentId != null) {
        servicesReference.doc(documentId).update(data).then((value) => null);
      } else {
        servicesReference
            .doc()
            .set(serviceModel.toJson())
            .then((value) => null)
            .onError((error, stackTrace) =>
                AppMessage.errorMessage(error.toString()));
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  /// Adds user to users collection
  Future<bool> addUser(UserModel user) async {
    try {
      usersReference.doc().set(user.toJson).then((value) => null).onError(
          (error, stackTrace) => AppMessage.errorMessage(error.toString()));
      usersCache[user.uid] = user;
      return true;
    } catch (error) {
      rethrow;
    }
  }

  /// Updates user information to users collections
  Future<bool> updateUser(UserModel updatedUser) async {
    try {
      usersReference
          .doc(updatedUser.uid)
          .update(updatedUser.toJson)
          .then((value) => null)
          .onError(
              (error, stackTrace) => AppMessage.errorMessage(error.toString()));
      usersCache[updatedUser.uid] = updatedUser;
      return true;
    } catch (error) {
      rethrow;
    }
  }

  /// Adds song to songs collection
  Future<bool> addSong(Song song) async {
    try {
      songsReference.doc().set(song.toJson).then((value) => null).onError(
          (error, stackTrace) => AppMessage.errorMessage(error.toString()));
      return true;
    } catch (error) {
      rethrow;
    }
  }

  /// Updates song
  Future<bool> updateSong(Song song) async {
    try {
      songsReference
          .doc(song.id)
          .update(song.toJson)
          .then((value) => null)
          .onError(
              (error, stackTrace) => AppMessage.errorMessage(error.toString()));
      return true;
    } catch (error) {
      rethrow;
    }
  }

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
  static const duty = 'duty';
  static const date = 'date';
  static const year = 'year';
  static const month = 'month';
  static const monthGroup = 'monthGroup';
  static const day = 'day';
  static const rehearsalDates = 'rehearsalDates';

  static const id = 'id';
  static const musicLinkString = 'musicLinkString';
  static const sheetLinkString = 'sheetLinkString';

  static const userId = 'userId';
  static const songId = 'songId';
  static const songName = 'songName';
  static const note = 'note';
  static const author = 'author';

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
