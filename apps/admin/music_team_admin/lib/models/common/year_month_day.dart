import 'package:equatable/equatable.dart';
import 'package:music_team_admin/api/providers/data_provider.dart';
import 'package:music_team_admin/extensions/date_time_extensions.dart';

class YearMonthDay extends Equatable implements Comparable<YearMonthDay> {
  int year;
  int month;
  int day;

  YearMonthDay({
    required this.year,
    required this.month,
    required this.day,
  });

  factory YearMonthDay.fromJson(Map<String, dynamic> json) {
    return YearMonthDay(
        year: json[DataProviderKey.year],
        month: json[DataProviderKey.month],
        day: json[DataProviderKey.day]);
  }

  Map<String, dynamic> toJson() {
    return {
      DataProviderKey.year: year,
      DataProviderKey.month: month,
      DataProviderKey.day: day,
    };
  }

  DateTime get dateTime {
    return DateTime(year, month, day);
  }

  String dateString({bool isYearDisplaying = false}) {
    if (isYearDisplaying) {
      return '${getMonthStringFromInt(month)} $day, $year';
    } else {
      return '${getMonthStringFromInt(month)} $day';
    }
  }

  static int numberOfDaysInMonth(int year, int month) {
    if (month == 2) {
      return DateTime(year, 3, 1).add(const Duration(days: -1)).day;
    } else if ([1, 3, 5, 7, 8, 10, 12].contains(month)) {
      return 31;
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    } else {
      return 0;
    }
  }

  static YearMonthDay getFirstWeekdayInMonth(int weekday, int year, int month) {
    final firstDayInMonth = DateTime(year, month, 1);
    return (weekday > firstDayInMonth.weekday)
        ? firstDayInMonth
            .add(Duration(days: weekday - firstDayInMonth.weekday))
            .yearMonthDay
        : firstDayInMonth
            .add(Duration(days: 7 + firstDayInMonth.weekday - weekday))
            .yearMonthDay;
  }

  static List<YearMonthDay> getWeekdaysInMonths(
      int weekday, int year, int fromMonth, int toMonth) {
    DateTime endDate =
        DateTime(year, toMonth, numberOfDaysInMonth(year, toMonth));

    List<YearMonthDay> days = [];
    DateTime currentDate =
        getFirstWeekdayInMonth(weekday, year, fromMonth).dateTime;
    while (currentDate.isBefore(endDate) || currentDate == endDate) {
      days.add(currentDate.yearMonthDay);
      currentDate = currentDate.add(const Duration(days: 7));
    }
    return days;
  }

  static YearMonthDay now() {
    DateTime today = DateTime.now();
    return YearMonthDay(year: today.year, month: today.month, day: today.day);
  }

  @override
  int compareTo(YearMonthDay other) {
    if (year != other.year) {
      return year - other.year;
    }
    if (month != other.month) {
      return month - other.month;
    }
    return day - other.day;
  }

  static List<List<int>> get getMonthsOptions {
    return [
      [1, 2],
      [3, 4],
      [5, 6],
      [7, 8],
      [9, 10],
      [11, 12]
    ];
  }

  static String getMonthsString(List<int> months) {
    int index = (months.last / 2).ceil() - 1;
    return monthsStrings[index];
  }

  static List<int> getMonthsList(String monthString) {
    final index = YearMonthDay.monthsStrings.indexOf(monthString);
    return getMonthsOptions[index];
  }

  static List<String> get monthsStrings {
    return [
      'January & February',
      'March & April',
      'May & June',
      'July & August',
      'September & October',
      'November & December',
    ];
  }

  static List<String> get yearStrings {
    // start from 2023
    List<String> years = [];
    for (var year = 2023; year <= now().year; year++) {
      years.add(year.toString());
    }
    return years;
  }

  @override
  List<Object?> get props => [year, month, day];

  int get monthGroup {
    return (month / 2).ceil();
  }

  static int getMonthGroupOfMonth(int month) {
    return (month / 2).ceil();
  }
}
