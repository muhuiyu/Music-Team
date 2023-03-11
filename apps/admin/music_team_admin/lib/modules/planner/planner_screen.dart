import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_team_admin/api/providers/data_provider.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/helpers/app_message.dart';
import 'package:music_team_admin/models/common/screen_name.dart';
import 'package:music_team_admin/models/common/year_month_day.dart';
import 'package:music_team_admin/models/service/service_model.dart';
import 'package:music_team_admin/models/user/user_model.dart';
import 'package:music_team_admin/models/user/user_role.dart';
import 'package:music_team_admin/modules/common/widgets/custom_page.dart';
import 'package:music_team_admin/modules/common/widgets/year_quarter_filter.dart';
import 'package:music_team_admin/modules/planner/planner_roster_table.dart';
import 'package:music_team_admin/modules/planner/planner_user_list.dart';
import 'package:provider/provider.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  late int _year = YearMonthDay.now().year;
  late int _startMonth = YearMonthDay.now().month.isOdd
      ? YearMonthDay.now().month
      : YearMonthDay.now().month + 1;
  final int _numberOfMonths = 2;
  late List<ServiceModel> _services;
  late Map<String, UserModel> _users;
  late DataProvider _dataProvider;

  @override
  void initState() {
    _services = [];
    _users = {};
    _dataProvider = Provider.of<DataProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() async {
    // fetch services
    _fetchServices();

    // fetch users
    _dataProvider.fetchAllUsers().then((value) {
      setState(() {
        _users = value;
      });
    }).onError(
        (error, stackTrace) => AppMessage.errorMessage(error.toString()));
  }

  _fetchServices() {
    _dataProvider
        .fetchServices(_year, _startMonth, _startMonth + _numberOfMonths - 1)
        .then((value) {
      setState(() {
        _services = value;
        _services.sort();
      });
    }).onError(
            (error, stackTrace) => AppMessage.errorMessage(error.toString()));
  }

  _onFilterValueChanged(int year, List<int> months) {
    setState(() {
      _year = year;
      _startMonth = months.first;
      _fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      currentScreen: ScreenName.planner,
      widgets: [
        Column(
          children: [
            Row(
              children: [
                const Spacer(),
                YearQuarterFilter(
                  onChanged: _onFilterValueChanged,
                ),
              ],
            ),
            Paddings.inlineSpacingBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _renderUserList(),
                const SizedBox(width: 36),
                PlannerRosterTable(
                  services: _services,
                  userMap: _users,
                  onSaveButtonPressed: _onSaveButtonPressed,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _renderUserList() {
    return PlannerUserList(
      users: _users.values.toList(),
      services: _services,
    );
  }

  _onSaveButtonPressed(
      ServiceModel serviceModel, UserRole role, List<UserModel> users) {
    serviceModel.duty[role] = users;
    setState(() {
      _services
          .firstWhere((element) => element.date == serviceModel.date)
          .duty = serviceModel.duty;
    });

    _dataProvider
        .updateUsersForRoleOnServiceDate(serviceModel, role, users)
        .then((value) {})
        .onError(
            (error, stackTrace) => AppMessage.errorMessage(error.toString()));
  }
}
