import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/models/common/year_month_day.dart';
import 'package:music_team_admin/models/user/user_model.dart';
import 'package:music_team_admin/models/user/user_role.dart';

class PlannerRoleBlock extends StatelessWidget {
  final YearMonthDay date;
  final UserRole role;
  final Map<String, UserModel> userMap;
  List<UserModel> selectedUsers;

  PlannerRoleBlock({
    super.key,
    required this.date,
    required this.role,
    required this.userMap,
    required this.selectedUsers,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            role.iconData,
            size: WidgetSize.plannerBlockIconSize,
            color: selectedUsers.isEmpty ? AppColors.grey : AppColors.white,
          ),
          const SizedBox(width: 4),
          Text(
            role.name,
            style: AppTextStyle.getTextStyle(AppFont.body,
                selectedUsers.isEmpty ? AppColors.grey : AppColors.white,
                weight: TextStyleWeight.bold),
          ),
        ],
      ),
      Paddings.cardGridInlineSpacingBox,
    ];
    widgets.addAll(selectedUsers.map((e) => _renderUserChip(e)).toList());

    return Container(
      height: WidgetSize.plannerBlockHeight,
      width: WidgetSize.plannerBlockWidth,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: selectedUsers.isEmpty
              ? AppColors.rosterTableBlockDefaultBackground
              : AppColors.rosterTableBlockFilledBackground,
          borderRadius: BorderRadius.circular(8)),
      child: Center(child: Column(children: widgets)),
    );
  }

  Widget _renderUserChip(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        label: Text(user.name),
      ),
    );
    // return CustomTextButton(
    //   text: user.name,
    //   onPressed: () {
    //     // TODO:
    //   },
    //   type: CustomButtonType.primaryWhite,
    // );
  }
}
