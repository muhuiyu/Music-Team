import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_models/music_roster_models.dart';

class PlannerUserList extends StatelessWidget {
  final List<UserModel> users;
  final List<ServiceModel> services;
  const PlannerUserList({
    super.key,
    required this.users,
    required this.services,
  });

  int get totalNumberOfWeeks => services.length;

  int getNumberOfDuty(String userId) {
    return services
        .where((element) => element.memberIds.contains(userId))
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.musiciansTitle,
          style: AppTextStyle.cardTitle,
        ),
        Paddings.cardGridInlineSpacingBox,
        Container(
          width: WidgetSize.plannerUserListWidth,
          decoration: BoxDecoration(
              color: AppColors.lightBackgroundGray,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: users
                .map((e) => PlannerUserListTile(
                    user: e,
                    numberOfDuty: getNumberOfDuty(e.uid),
                    totalNumberOfWeeks: totalNumberOfWeeks))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class PlannerUserListTile extends StatelessWidget {
  final UserModel user;
  final int numberOfDuty;
  final int totalNumberOfWeeks;
  const PlannerUserListTile(
      {super.key,
      required this.user,
      required this.numberOfDuty,
      required this.totalNumberOfWeeks});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.roles.map((e) => e.name).join(', ')),
      trailing: Text(
        '${numberOfDuty}/${totalNumberOfWeeks} weeks',
        style: AppTextStyle.getTextStyle(AppFont.body, Colors.blue),
      ),
    );
  }
}
