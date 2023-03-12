import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_roster_api/models/app_message.dart';
import 'package:music_roster_api/src/base/base_provider.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:year_month_day/year_month_day.dart';

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

  Future<UserModel?> getUserProfile() async {
    // if (FirebaseAuth.instance.currentUser != null) {
    // TODO: fetch user data
    // }
    return null;
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

  Future<List<TeamNotification>> fetchNotifications() {
    // TODO: change to real data
    return Future(() => []);
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
