import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_api/music_roster_api.dart';
import 'package:music_team_admin/models/common/screen_name.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:music_team_admin/modules/common/widgets/custom_page.dart';
import 'package:music_team_admin/modules/dashboard/service_details_dialog.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<ServiceModel> _upcomingServices;
  late DataProvider _dataProvider;

  @override
  void initState() {
    _upcomingServices = [];
    _dataProvider = Provider.of<DataProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() async {
    _dataProvider.fetchUpcomingServices(numberOfServices: 2).then((value) {
      setState(() {
        _upcomingServices = value;
      });
    }).onError(
        (error, stackTrace) => AppMessage.errorMessage(error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      currentScreen: ScreenName.dashboard,
      widgets: [
        _renderUpcomingServices(),
      ],
    );
  }

  Widget _renderUpcomingServices() {
    List<Widget> widgets = [
      Text(
        'Upcoming services',
        style: AppTextStyle.getTextStyle(AppFont.h2, AppColors.label,
            weight: TextStyleWeight.bold),
      ),
      Paddings.inlineSpacingBox,
    ];
    widgets.add(Column(
        children: _upcomingServices
            .map((serviceModel) => UpcomingServiceCard(
                  serviceModel: serviceModel,
                  onViewMoreButtonPressed: () {
                    _onViewMoreButtonPressed(context, serviceModel);
                  },
                ))
            .toList()));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  _onViewMoreButtonPressed(
    BuildContext context,
    ServiceModel serviceModel,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return ServiceDetailsDialog(serviceModel: serviceModel);
      },
    );
  }
}

class UpcomingServiceCard extends StatelessWidget {
  const UpcomingServiceCard({
    super.key,
    required this.serviceModel,
    required this.onViewMoreButtonPressed,
  });
  final ServiceModel serviceModel;
  final Function() onViewMoreButtonPressed;

  _renderDetailsSection(String title, List<Widget> widgets) {
    widgets.insertAll(0, [
      Text(
        title.toUpperCase(),
        style: AppTextStyle.cardSectionTitle,
      ),
      Paddings.cardGridInlineSpacingBox,
    ]);
    return Container(
      margin: const EdgeInsets.only(right: 24),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 12, bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceModel.date.dateString(isYearDisplaying: true),
              style: AppTextStyle.cardTitle,
            ),
            Paddings.inlineSpacingBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _renderDetailsSection(
                  'Rehearsal dates',
                  serviceModel.rehearsalDates
                      .map<Widget>((e) => Text(
                            e.dateString(),
                            style: AppTextStyle.cardSectionText,
                          ))
                      .toList(),
                ),
                _renderDetailsSection('Lead', [
                  Text(
                    serviceModel.duty[UserRole.lead]?.first.name ??
                        'Not decided',
                    style: AppTextStyle.cardSectionText,
                  ),
                ]),
              ],
            ),
            Paddings.inlineSpacingBox,
            _renderDetailsSection('Song', [
              Text(
                '${serviceModel.songs.map((e) => e.songName).join(', ')}',
                style: AppTextStyle.cardSectionText,
              ),
            ]),
            Paddings.inlineSpacingBox,
            ElevatedButton(
                onPressed: onViewMoreButtonPressed, child: Text('View details'))
          ],
        ),
      ),
    );
  }
}
