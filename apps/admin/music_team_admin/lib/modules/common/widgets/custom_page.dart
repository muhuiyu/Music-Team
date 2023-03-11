import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/models/common/screen_name.dart';
import 'package:music_team_admin/modules/common/widgets/custom_page_header.dart';
import 'package:music_team_admin/modules/common/widgets/navigation_drawer.dart';
import 'package:music_team_admin/responsive/menu_app_controller.dart';
import 'package:music_team_admin/responsive/responsive.dart';
import 'package:provider/provider.dart';

enum CustomPageType { root, modal, sub }

class CustomPage extends StatelessWidget {
  final ScreenName currentScreen;
  final List<Widget> widgets;
  final Function()? onSaveButtonPressed;
  final bool isDrawerEnabled;
  final Color? backgroundColor;

  const CustomPage({
    super.key,
    required this.currentScreen,
    required this.widgets,
    this.isDrawerEnabled = true,
    this.onSaveButtonPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    widgets.insert(0, CustomPageHeader(screenName: currentScreen));

    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: isDrawerEnabled
          ? AppNavigationDrawer(currentScreen: currentScreen)
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                  child: AppNavigationDrawer(currentScreen: currentScreen)),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: Paddings.pageHeader,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
