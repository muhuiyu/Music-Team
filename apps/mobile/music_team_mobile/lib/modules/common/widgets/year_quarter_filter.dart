// import 'package:flutter/material.dart';
// import 'package:kpi_tracker/constants/constants.dart';
// import 'package:kpi_tracker/extensions/string_extensions.dart';
// import 'package:kpi_tracker/model/common/year_quarter.dart';
// import 'package:kpi_tracker/widgets/custom_dropdown.dart';

// // ignore: must_be_immutable
// class YearQuarterFilter extends StatefulWidget {
//   Function(YearQuarter) onChanged;
//   YearQuarterFilter({
//     super.key,
//     required this.onChanged,
//   });

//   @override
//   State<YearQuarterFilter> createState() => _YearQuarterFilterState();
// }

// class _YearQuarterFilterState extends State<YearQuarterFilter> {
//   YearQuarter selectedYearQuarter = YearQuarter.current();
//   List<String> _quarterOptions =
//       YearQuarter.getQuarterOptionsIn(YearQuarter.current().year);

//   _onChanged(String? updatedYearString, String? updatedQuarterString) {
//     int updatedYear = selectedYearQuarter.year;
//     int updatedQuarter = selectedYearQuarter.quarter;

//     if (updatedYearString != null && updatedYearString.isNotEmpty) {
//       updatedYear = int.parse(updatedYearString);
//       updatedQuarter =
//           YearQuarter.getLastQuarterIn(updatedYear); // reset quarter
//     } else if (updatedQuarterString != null &&
//         updatedQuarterString.isNotEmpty) {
//       updatedQuarter = YearQuarter.parseQuarterString(updatedQuarterString);
//     }

//     setState(() {
//       selectedYearQuarter =
//           YearQuarter(year: updatedYear, quarter: updatedQuarter);
//       _quarterOptions = [];
//       _quarterOptions =
//           YearQuarter.getQuarterOptionsIn(selectedYearQuarter.year);
//       widget.onChanged(selectedYearQuarter);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       CustomDropDown(
//         items: YearQuarter.yearStrings(),
//         value: selectedYearQuarter.year.toString(),
//         title: AppText.year.capitalizeFirstLetter(),
//         onChanged: (newValue) {
//           _onChanged(newValue, null);
//         },
//         titlePosition: CustomDropDownTitlePosition.left,
//       ),
//       const SizedBox(width: 24),
//       CustomDropDown(
//         items: _quarterOptions,
//         value: selectedYearQuarter.quarterString,
//         title: AppText.quarter.capitalizeFirstLetter(),
//         onChanged: (newValue) {
//           _onChanged(null, newValue);
//         },
//         titlePosition: CustomDropDownTitlePosition.left,
//       ),
//     ]);
//   }
// }
