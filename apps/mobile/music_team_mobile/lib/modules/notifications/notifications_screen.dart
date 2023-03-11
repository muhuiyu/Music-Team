import 'package:flutter/material.dart';
import 'package:music_team_mobile/api/providers/data_provider.dart';
import 'package:music_team_mobile/constants/app_text.dart';
import 'package:music_team_mobile/helpers/app_message.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/models/notifications/team_notification.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_page.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<TeamNotification> items = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _fetchData();
    });
  }

  _fetchData() async {
    items = await Provider.of<DataProvider>(context, listen: false)
        .fetchNotifications()
        .onError(
            (error, stackTrace) => AppMessage.errorMessage(error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO:
    return CustomPage(currentScreen: ScreenName.notifications, widgets: [
      Text('test'),
      // ListView.builder(
      //   itemCount: items.length,
      //   itemBuilder: (context, index) => ListTile(
      //     title: Text(items[index].title),
      //     onTap: () {
      //       items[index].onPressed;
      //     },
      //   ),
      // ),
    ]);
  }
}
