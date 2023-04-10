import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/mock_data.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:year_month_day/year_month_day.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:music_team_mobile/modules/common/screens/base_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late int _selectedYear;
  late int _selectedMonth;
  late List<ServiceModel> _services = [];
  late YearMonthDay _selectedDay = YearMonthDay.now();

  @override
  void initState() {
    _selectedYear = YearMonthDay.now().year;
    _selectedMonth = YearMonthDay.now().month;
    _selectedDay = YearMonthDay.now();
    Future.delayed(Duration.zero, () {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() async {
    // TODO: add data provider
    setState(() {
      _services = [serviceModelTestEntry];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(MonthlyCalendar(
        selectedMonth: _selectedMonth,
        selectedYear: _selectedYear,
        services: _services));
    widgets.add(_renderEventPreview());
    return BaseScreen(currentScreen: ScreenName.calendar, widgets: widgets);
  }

  _renderEventPreview() {
    return Card(
      child: Column(children: [
        Text(_selectedDay.dateString()),
      ]),
    );
  }
}

class MonthlyCalendar extends StatelessWidget {
  const MonthlyCalendar({
    super.key,
    required int selectedMonth,
    required int selectedYear,
    required this.services,
  })  : _selectedMonth = selectedMonth,
        _selectedYear = selectedYear;

  final int _selectedMonth;
  final int _selectedYear;
  final List<ServiceModel> services;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      _renderCalenderHeader(),
      const SizedBox(height: 12),
      _renderWeekdays(),
    ];

    widgets.addAll(_renderWeeks());
    return Column(children: widgets);
  }

  _renderCalenderHeader() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              // TODO: go to previous month
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 12,
            )),
        Spacer(),
        Text(
          '${getMonthStringFromInt(_selectedMonth)} $_selectedYear',
          style: AppTextStyle.cardGridTitle,
        ),
        Spacer(),
        IconButton(
            onPressed: () {
              // TODO: go to next month
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 12,
            )),
      ],
    );
  }

  _renderWeekdays() {
    final weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightBackgroundGray,
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekdays
            .map((e) => Text(e, style: AppTextStyle.calendarHeader))
            .toList(),
      ),
    );
  }

  _renderWeeks() {
    final weeks = YearMonthDay.getWeeks(_selectedYear, _selectedMonth);
    List<Widget> widgets = weeks
        .map((week) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: week.map((date) => _configureDateItem(date)).toList(),
              ),
            ))
        .toList();
    return widgets;
  }

  Widget _configureDateItem(YearMonthDay date) {
    final status = _configureDateStatus(date);
    Color circleColor;

    switch (status) {
      case DateStatus.normal:
        circleColor = Colors.transparent;
        break;
      case DateStatus.rehearsal:
        circleColor = AppColors.kpiGreen;
        break;
      case DateStatus.service:
        circleColor = AppColors.primary;
        break;
    }

    const double radius = 3;
    return Column(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: GestureDetector(
            child: Center(
              child: Text(
                date.day.toString(),
                textAlign: TextAlign.center,
                style: AppTextStyle.calendarText,
              ),
            ),
            onTap: () {
              // TODO:
              log(date.day.toString());
            },
          ),
        ),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
              color: circleColor, borderRadius: BorderRadius.circular(radius)),
          height: radius * 2,
          width: radius * 2,
        ),
      ],
    );
  }

  DateStatus _configureDateStatus(YearMonthDay date) {
    for (var element in services) {
      if (element.date == date) {
        return DateStatus.service;
      }
      if (element.rehearsalDates.contains(date)) {
        return DateStatus.rehearsal;
      }
    }
    return DateStatus.normal;
  }
}

enum DateStatus { normal, rehearsal, service }
