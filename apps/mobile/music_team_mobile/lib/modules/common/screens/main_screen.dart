import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_app_bar.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:music_team_mobile/modules/common/widgets/navigation_drawer.dart';

class MainScreen extends StatefulWidget {
  final ScreenName currentScreen;
  final Function()? onSaveButtonPressed;
  final bool isDrawerEnabled;

  const MainScreen({
    super.key,
    required this.currentScreen,
    this.onSaveButtonPressed,
    this.isDrawerEnabled = false,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScreenName _currentScreen;
  late Widget _widget;

  @override
  void initState() {
    _currentScreen = widget.currentScreen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _widget = _currentScreen.widget;
    return Scaffold(
      backgroundColor: _currentScreen.backgroundColor,
      appBar: CustomAppBar(
        currentScreen: _currentScreen,
        onPressedBackButton: () {
          Get.back();
        },
        onPressedSaveButton: () {
          if (widget.onSaveButtonPressed != null) {
            widget.onSaveButtonPressed!();
          }
        },
      ),
      drawer: widget.isDrawerEnabled
          ? AppNavigationDrawer(currentScreen: _currentScreen)
          : null,
      body: _widget,
      bottomNavigationBar: _currentScreen.isRoot
          ? CustomBottomNavigationBar(
              currentIndex: _currentScreen.bottomBarIndex,
            )
          : null,
    );
  }
}
