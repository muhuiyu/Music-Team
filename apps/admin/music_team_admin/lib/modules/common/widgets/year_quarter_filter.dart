import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/extensions/string_extensions.dart';
import 'package:music_team_admin/models/common/year_month_day.dart';
import 'package:music_team_admin/widgets/custom_dropdown.dart';

class YearQuarterFilter extends StatefulWidget {
  final Function(int year, List<int> months) onChanged;
  const YearQuarterFilter({
    super.key,
    required this.onChanged,
  });

  @override
  State<YearQuarterFilter> createState() => _YearQuarterFilterState();
}

class _YearQuarterFilterState extends State<YearQuarterFilter> {
  int selectedYear = YearMonthDay.now().year;
  List<int> selectedMonths = [];

  @override
  void initState() {
    super.initState();
    final currentMonth = YearMonthDay.now().month;
    selectedMonths = currentMonth.isOdd
        ? [currentMonth, currentMonth + 1]
        : [currentMonth - 1, currentMonth];
  }

  _onChanged(String? updatedYearString, String? updatedMonthsString) {
    int updatedYear = updatedYearString == null
        ? selectedYear
        : int.parse(updatedYearString!);

    List<int> updatedMonths = updatedMonthsString == null
        ? selectedMonths
        : YearMonthDay.getMonthsList(updatedMonthsString);

    setState(() {
      selectedYear = updatedYear;
      updatedMonths = selectedMonths;
      widget.onChanged(updatedYear, updatedMonths);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CustomDropDown(
        items: YearMonthDay.yearStrings,
        value: selectedYear.toString(),
        title: AppText.year.capitalizeFirstLetter(),
        onChanged: (newValue) {
          _onChanged(newValue, null);
        },
        titlePosition: CustomDropDownTitlePosition.left,
      ),
      const SizedBox(width: 24),
      CustomDropDown(
        items: YearMonthDay.monthsStrings,
        value: YearMonthDay.getMonthsString(selectedMonths),
        title: AppText.months.capitalizeFirstLetter(),
        onChanged: (newValue) {
          _onChanged(null, newValue);
        },
        titlePosition: CustomDropDownTitlePosition.left,
      ),
    ]);
  }
}
