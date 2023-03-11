import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/models/common/year_month_day.dart';
import 'package:music_team_mobile/modules/common/screens/base_screen.dart';
import 'package:music_team_mobile/widgets/custom_dropdown.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      currentScreen: ScreenName.team,
      widgets: [
        // TODO:
        Row(
          children: [
            CustomDropDown(
              items: ['2023', '2024'],
              title: AppText.year,
              onChanged: (item) {
                // TODO:
              },
              titlePosition: CustomDropDownTitlePosition.left,
            ),
            const SizedBox(width: 12),
            CustomDropDown(
              items: YearMonthDay.monthsStrings,
              title: AppText.month,
              onChanged: (item) {
                // TODO:
              },
              titlePosition: CustomDropDownTitlePosition.left,
            ),
          ],
        ),

        _renderRosterTable(),
      ],
    );
  }

  Widget _renderRosterTable() {
    // TODO:
    return Container();
  }
}
