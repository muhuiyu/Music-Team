import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_app_bar.dart';
import 'package:music_team_mobile/modules/common/widgets/navigation_drawer.dart';

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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        currentScreen: currentScreen,
        onPressedBackButton: () {
          Get.back();
        },
        onPressedSaveButton: () {
          if (onSaveButtonPressed != null) {
            onSaveButtonPressed!();
          }
        },
      ),
      drawer: isDrawerEnabled
          ? AppNavigationDrawer(currentScreen: currentScreen)
          : null,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: Paddings.pageHeader,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      )),
      bottomNavigationBar: currentScreen.isRoot
          ? const CustomBottomNavigationBar(
              currentIndex: 0,
            )
          : null,
    );
  }
}
