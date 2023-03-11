import 'package:music_team_mobile/api/providers/data_provider.dart';
import 'package:music_team_mobile/models/common/year_month_day.dart';
import 'package:music_team_mobile/models/service/song_record.dart';
import 'package:music_team_mobile/models/user/user_role.dart';

class ServiceModel implements Comparable<ServiceModel> {
  YearMonthDay date;
  List<YearMonthDay> rehearsalDates;
  Map<String, List<UserRole>> members;
  List<SongRecord> songs;

  // extra information
  String message;

  ServiceModel({
    required this.date,
    required this.members,
    required this.rehearsalDates,
    this.message = '',
    required this.songs,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final YearMonthDay date = YearMonthDay(
        year: json[DataProviderKey.year],
        month: json[DataProviderKey.month],
        day: json[DataProviderKey.day]);

    List<YearMonthDay> rehearsalDates = (json[DataProviderKey.rehearsalDates]
            as List<dynamic>)
        .map(
            (element) => YearMonthDay.fromJson(element as Map<String, dynamic>))
        .toList();

    Map<String, List<UserRole>> members = {};
    List<SongRecord> songs = [];

    (json[DataProviderKey.members] as Map<String, dynamic>)
        .entries
        .forEach((element) {
      List<UserRole> roles = [];
      (element.value as List<dynamic>).forEach((element) {
        final role = UserRole.getUserRoleFromString((element as String));
        if (role != null) {
          roles.add(role);
        }
      });
      members[element.key] = roles;
    });

    (json[DataProviderKey.songs] as List<dynamic>).forEach((element) {
      songs.add(SongRecord.fromJson(element as Map<String, dynamic>));
    });

    return ServiceModel(
        date: date,
        rehearsalDates: rehearsalDates,
        members: members,
        songs: songs);
  }

  String? get leadId {
    for (var element in members.entries) {
      if (element.value.contains(UserRole.lead)) {
        return element.key;
      }
    }
    return null;
  }

  @override
  int compareTo(ServiceModel other) {
    return date.compareTo(other.date);
  }
}
