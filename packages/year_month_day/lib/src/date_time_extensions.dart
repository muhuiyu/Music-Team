import 'year_month_day_base.dart';

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

List<DateTime> getSundaysInMonth(int year, int month) {
  return [];
}
