// import 'package:date_util/date_util.dart';
// import 'package:equatable/equatable.dart';
// import 'package:kpi_tracker/constants/constants.dart';
// import 'package:kpi_tracker/extensions/date_time_extensions.dart';
// import 'package:kpi_tracker/model/common/year_month_week.dart';

// // ignore: must_be_immutable
// class YearQuarter extends Equatable implements Comparable<YearQuarter> {
//   int year;
//   int quarter; // 1, 2, 3, 4

//   YearQuarter({
//     required this.year,
//     required this.quarter,
//   });

//   int get firstMonth {
//     return months.first;
//   }

//   int getMonth(int index) {
//     return months[index];
//   }

//   List<int> get months {
//     return [1, 2, 3].map((i) => (quarter - 1) * 4 + i).toList();
//   }

//   List<YearMonthWeek> getWeeksInMonth(int month) {
//     var numberOfWeeks = YearQuarter.getNumberOfWeeksInMonth(year, month);

//     List<YearMonthWeek> weeks = [];
//     for (var i = 1; i <= numberOfWeeks; i++) {
//       weeks.add(YearMonthWeek(year: year, month: month, week: i));
//     }
//     return weeks;
//   }

//   static int getNumberOfWeeksInMonth(int year, int month) {
//     var firstSundayInMonth =
//         DateTime(year, month, 1).getFirstCertainWeekdayInMonth(DateTime.sunday);
//     var numberOfDaysInMonth = DateUtil().daysInMonth(month, year);
//     return ((numberOfDaysInMonth - firstSundayInMonth.day) / 7).ceil();
//   }

//   String get quarterString {
//     switch (quarter) {
//       case 1:
//         return 'Q1';
//       case 2:
//         return 'Q2';
//       case 3:
//         return 'Q3';
//       case 4:
//         return 'Q4';
//       default:
//         return '';
//     }
//   }

//   DateTime get startDate {
//     switch (quarter) {
//       case 1:
//         return DateTime(year, 1, 1);
//       case 2:
//         return DateTime(year, 4, 1);
//       case 3:
//         return DateTime(year, 7, 1);
//       case 4:
//         return DateTime(year, 10, 1);
//       default:
//         return DateTime(year, 1, 1);
//     }
//   }

//   DateTime get endDate {
//     switch (quarter) {
//       case 1:
//         return DateTime(year, 3, 31);
//       case 2:
//         return DateTime(year, 6, 30);
//       case 3:
//         return DateTime(year, 9, 30);
//       case 4:
//         return DateTime(year, 12, 31);
//       default:
//         return DateTime(year, 3, 31);
//     }
//   }

//   String get yearQuarterString {
//     return '${year.toString()} $quarterString';
//   }

//   String get startAndEndDateString {
//     return '${AppText.startFrom} ${startDate.toDateString()} ${AppText.to} ${endDate.toDateString()}';
//   }

//   YearQuarter get previous {
//     if (quarter == 1) {
//       return YearQuarter(year: year - 1, quarter: 4);
//     } else {
//       return YearQuarter(year: year, quarter: quarter - 1);
//     }
//   }

//   // Static functions
//   static YearQuarter current() {
//     return YearQuarter(
//         year: DateTime.now().year,
//         quarter: DateTime.now().month.monthToQuarter());
//   }

//   static List<String> yearStrings() {
//     const startYear = 2023;
//     List<String> years = [];
//     for (var year = YearQuarter.current().year; year >= startYear; year--) {
//       years.add(year.toString());
//     }
//     return years;
//   }

//   static List<String> getQuarterOptionsIn(int year) {
//     final allQuarters = ['Q4', 'Q3', 'Q2', 'Q1'];
//     if (year < current().year) {
//       return allQuarters;
//     }
//     switch (current().quarter) {
//       case 1:
//         return [allQuarters.last];
//       case 2:
//         return allQuarters.sublist(2, 3);
//       case 3:
//         return allQuarters.sublist(1, 3);
//       case 4:
//         return allQuarters;
//       default:
//         return [];
//     }
//   }

//   static int getLastQuarterIn(int year) {
//     if (year < current().year) {
//       return 4;
//     } else {
//       return current().quarter;
//     }
//   }

//   static int parseQuarterString(String quarterString) {
//     switch (quarterString) {
//       case 'Q1':
//         return 1;
//       case 'Q2':
//         return 2;
//       case 'Q3':
//         return 3;
//       case 'Q4':
//         return 4;
//       default:
//         return 0;
//     }
//   }

//   @override
//   List<Object?> get props => [year, quarter];

//   @override
//   int compareTo(YearQuarter other) {
//     if (year != other.year) {
//       return year - other.year;
//     } else {
//       return quarter - other.quarter;
//     }
//   }
// }

// extension IntExtension on int {
//   int monthToQuarter() {
//     if (this < 0 || this > 12) {
//       // error
//       return 0;
//     }
//     return (this / 4).ceil();
//   }
// }
