import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/models/common/screen_name.dart';
import 'package:music_team_admin/responsive/menu_app_controller.dart';
import 'package:music_team_admin/responsive/responsive.dart';
import 'package:provider/provider.dart';

class CustomPageHeader extends StatelessWidget {
  final ScreenName screenName;
  const CustomPageHeader({
    super.key,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: Icon(Icons.menu, size: WidgetSize.drawerIcon),
              onPressed: context.read<MenuAppController>().controlMenu,
            ),
          if (!Responsive.isDesktop(context)) const SizedBox(width: 24),
          if (!Responsive.isMobile(context))
            Text(screenName.name,
                style: AppTextStyle.getTextStyle(AppFont.h1, AppColors.label,
                    weight: TextStyleWeight.heavy)),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          // Expanded(child: SearchBar()),
          CustomPageHeaderProfileChip()
        ],
      ),
    );
  }
}

class CustomPageHeaderProfileChip extends StatelessWidget {
  const CustomPageHeaderProfileChip({
    Key? key,
  }) : super(key: key);

  // TODO: add to real data
  final String username = 'Grace Yu';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        // color: AppColors.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_2_rounded),
          if (!Responsive.isMobile(context))
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(username),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
