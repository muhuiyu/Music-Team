import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/constants/app_colors.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.currentIndex;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Get.offAndToNamed(ScreenName.roots[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.primary,
      onTap: _onItemTapped,
      items: ScreenName.roots
          .map((e) => BottomNavigationBarItem(
                icon: Icon(e.getIconData(false)),
                activeIcon: Icon(e.getIconData(true)),
                label: e.name,
              ))
          .toList(),
      type: BottomNavigationBarType.fixed,
    );
  }
}
