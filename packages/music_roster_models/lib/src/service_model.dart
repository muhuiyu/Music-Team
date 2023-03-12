import 'package:year_month_day/year_month_day.dart';
import 'user_model.dart';
import 'user_role.dart';
import 'song_record.dart';

class ServiceModelKey {
  static const String monthGroup = 'monthGroup';
  static const String rehearsalDates = 'rehearsalDates';
  static const String duty = 'duty';
  static const String songs = 'songs';
}

class ServiceModel implements Comparable<ServiceModel> {
  YearMonthDay date;
  List<YearMonthDay> rehearsalDates;
  Map<UserRole, List<UserModel>> duty;
  List<SongRecord> songs;

  // extra information
  String message;

  ServiceModel({
    required this.date,
    required this.duty,
    required this.rehearsalDates,
    this.message = '',
    required this.songs,
  });

  factory ServiceModel.fromJson(
      Map<String, dynamic> json, Map<String, UserModel> userMap) {
    final YearMonthDay date = YearMonthDay(
        year: json[YearMonthDayKey.year],
        month: json[YearMonthDayKey.month],
        day: json[YearMonthDayKey.day]);

    List<YearMonthDay> rehearsalDates = (json[ServiceModelKey.rehearsalDates]
            as List<dynamic>)
        .map(
            (element) => YearMonthDay.fromJson(element as Map<String, dynamic>))
        .toList();

    Map<UserRole, List<UserModel>> duty = {};
    (json[ServiceModelKey.duty] as Map<String, dynamic>)
        .entries
        .forEach((element) {
      final role = UserRole.getUserRoleFromString(element.key);
      if (role != null) {
        List<UserModel> users = [];
        duty[role] = (element.value as List<dynamic>)
            .map<String>((e) => e)
            .fold(users, (previousValue, id) {
          if (userMap[id] != null) {
            previousValue.add(userMap[id]!);
          }
          return previousValue;
        }).toList();
      }
    });

    List<SongRecord> songs = [];
    (json[ServiceModelKey.songs] as List<dynamic>).forEach((element) {
      songs.add(SongRecord.fromJson(element as Map<String, dynamic>));
    });

    return ServiceModel(
        date: date, rehearsalDates: rehearsalDates, duty: duty, songs: songs);
  }

  Map<String, dynamic> get dutyJson {
    Map<String, dynamic> dutyJson = {};
    duty.keys.forEach((key) {
      dutyJson[key.key] = duty[key]?.map((e) => e.uid).toList();
    });
    return dutyJson;
  }

  Map<String, dynamic> toJson() {
    return {
      YearMonthDayKey.year: date.year,
      YearMonthDayKey.month: date.month,
      YearMonthDayKey.day: date.day,
      ServiceModelKey.monthGroup: date.monthGroup,
      ServiceModelKey.duty: dutyJson,
      ServiceModelKey.rehearsalDates: rehearsalDates.map((e) => e.toJson()),
      ServiceModelKey.songs: songs.map((e) => e.toJson()),
    };
  }

  List<String> get memberIds {
    return duty.values.fold(<String>{}, (previousValue, element) {
      previousValue.addAll(element.map((e) => e.uid));
      return previousValue;
    }).toList();
  }

  String? get leadId {
    final leads = duty[UserRole.lead.key];
    return leads?.first.uid;
  }

  @override
  int compareTo(ServiceModel other) {
    return date.compareTo(other.date);
  }
}
