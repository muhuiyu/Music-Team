import 'package:flutter/material.dart';
import 'package:music_team_mobile/api/mock_data.dart';
import 'package:music_team_mobile/constants/app_text_style.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/models/service/service_model.dart';
import 'package:music_team_mobile/modules/common/screens/base_screen.dart';
import 'package:music_team_mobile/modules/common/widgets/page_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<ServiceModel> _upcomingServices = [];

  @override
  void initState() {
    // TODO: implement initState
    _upcomingServices = [serviceModelTestEntry];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      currentScreen: ScreenName.dashboard,
      widgets: [
        _renderHeader(),
        _renderUpcomingServices(),
      ],
    );
  }

  Widget _renderHeader() {
    // TODO:
    return Container();
  }

  Widget _renderUpcomingServices() {
    // TODO:
    List<Widget> widgets = [
      Text(
        'Upcoming services',
        style: AppTextStyle.cardTitle,
      ),
      Paddings.inlineSpacingBox
    ];
    widgets.addAll(_upcomingServices.map((e) => _renderUpcomingServiceCard(e)));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _renderUpcomingServiceCard(ServiceModel serviceModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    serviceModel.date.dateString(),
                    style: AppTextStyle.cardGridTitle,
                  ),
                  const Spacer(),
                ],
              ),
              Paddings.cardHeaderInlineSpacing,
              Text('Piano'),
            ]),
      ),
    );
  }

  Widget _renderNotification() {
    // TODO:
    return Container();
  }
}
