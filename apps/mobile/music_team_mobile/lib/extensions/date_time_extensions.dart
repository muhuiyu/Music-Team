import 'package:music_team_mobile/models/common/year_month_day.dart';

enum DateFormat {
  full,
  normal,
  short,
}

extension DateTimeExtension on DateTime {
  String toDateString() {
    return '$day ${getMonthStringFromInt(month, format: DateFormat.short)}, $year';
  }

  YearMonthDay get yearMonthDay {
    return YearMonthDay(year: year, month: month, day: day);
  }

  DateTime getFirstCertainWeekdayInMonth(int weekday) {
    var firstDayOfMonth = DateTime(year, month, 1);
    var dayDifference = weekday >= firstDayOfMonth.weekday
        ? weekday - firstDayOfMonth.weekday
        : weekday - firstDayOfMonth.weekday + 7;
    return firstDayOfMonth.add(Duration(days: dayDifference));
  }

  // DateTime get lastDayInMonth {
  // var numberOfDaysInMonth = DateUtil().daysInMonth(month - 1, year);
  // return DateTime(year, month, 1)
  //     .add(Duration(days: numberOfDaysInMonth - 1));
  // }

  static const Map<int, String> fullMonthStrings = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
}

String getMonthStringFromInt(int month,
    {DateFormat format = DateFormat.normal}) {
  if (month < 1 || month > 12) {
    return '';
  }
  if (format == DateFormat.full) {
    return DateTimeExtension.fullMonthStrings[month] ?? '';
  } else {
    return DateTimeExtension.fullMonthStrings[month]?.substring(0, 3) ?? '';
  }
}

// int getMonthIntFromString(String rawString) {
//   final isUsingAbbreviation = rawString.length == 3;

//   var monthItem =
//       DateTimeExtension.fullMonthStrings.entries.firstWhereOrNull((element) {
//     var endIndex = isUsingAbbreviation ? 3 : element.value.length;
//     if (element.value.toLowerCase().substring(0, endIndex) ==
//         rawString.toLowerCase()) {
//       return true;
//     }
//     return false;
//   });
//   return monthItem == null ? 0 : monthItem.key;
// }

List<DateTime> getSundaysInMonth(int year, int month) {
  return [];
}
