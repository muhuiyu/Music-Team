import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/router/router.dart';

class NavigationDrawerEntry {
  final ScreenName screen;
  final List<NavigationDrawerEntry> children;
  NavigationDrawerEntry(this.screen,
      [this.children = const <NavigationDrawerEntry>[]]);
}

// ignore: must_be_immutable
class AppNavigationDrawer extends StatelessWidget {
  ScreenName currentScreen;

  AppNavigationDrawer({
    super.key,
    required this.currentScreen,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [_renderDrawerHeader()];
    widgets.addAll(_renderList(context, currentScreen));
    return Drawer(
      backgroundColor: AppColors.darkBlue,
      child: Column(
        children: widgets,
      ),
    );
  }

  _onLogoutTap() {
    // TODO: connect to logout
    Get.toNamed(Routes.loginScreen);
  }

  Widget _renderDrawerHeader() {
    return Padding(
        padding: Paddings.drawerHeader,
        child: Image.asset(
          AppImage.appLogo,
          width: WidgetSize.drawerLogoWidth,
        ));
  }

  List<Widget> _renderList(BuildContext context, ScreenName currentScreen) {
    final List<NavigationDrawerEntry> data = <NavigationDrawerEntry>[
      // NavigationDrawerEntry(ScreenName.weeklyKpi),
      // NavigationDrawerEntry(ScreenName.report),
      // NavigationDrawerEntry(
      //   ScreenName.settings,
      //   <NavigationDrawerEntry>[
      //     NavigationDrawerEntry(ScreenName.manageKpi),
      //     NavigationDrawerEntry(ScreenName.manageEmployee),
      //   ],
      // ),
    ];

    List<Widget> tiles = data
        .map((element) => _renderTiles(context, element, currentScreen))
        .toList();

    tiles.addAll([
      const Spacer(),
      _renderLogoutTile(),
      Paddings.drawerBottomSpacingBox,
    ]);

    return tiles;
  }

  Widget _renderTiles(BuildContext context, NavigationDrawerEntry root,
      ScreenName currentScreen) {
    var isSelected = root.screen == currentScreen;

    if (root.children.isEmpty) {
      return ListTile(
        selectedTileColor: AppColors.primary,
        contentPadding: Paddings.drawerListTile,
        leading: _renderListTileIcon(root),
        title: _renderListTileTitle(root, isSelected),
        onTap: () {
          Get.toNamed('/${root.screen.id}');
        },
        selectedColor: AppColors.primary,
        focusColor: AppColors.primary,
        selected: isSelected,
      );
    }
    return ExpansionTile(
      key: PageStorageKey<NavigationDrawerEntry>(root),
      tilePadding: Paddings.drawerListTile,
      leading: _renderListTileIcon(root),
      title: _renderListTileTitle(root, isSelected),
      collapsedIconColor: isSelected ? AppColors.label : AppColors.white,
      children: root.children
          .map((e) => _renderTiles(context, e, currentScreen))
          .toList(),
    );
  }

  Widget _renderListTileIcon(NavigationDrawerEntry root) {
    // return root.screen.hasIcon
    //     ? Image.asset(
    //         root.screen.getIconName(root.screen == currentScreen),
    //         width: WidgetSize.drawerIcon,
    //         height: WidgetSize.drawerIcon,
    //       )
    //     : Paddings.drawerIcon;
    return Paddings.drawerIcon;
  }

  Widget _renderListTileTitle(NavigationDrawerEntry root, bool isSelected) {
    return Text(
      root.screen.name,
      style: AppTextStyle.getNavigationBarItemTextStyle(isSelected),
    );
  }

  Widget _renderLogoutTile() {
    return ListTile(
      selectedTileColor: AppColors.primary,
      contentPadding: Paddings.drawerListTile,
      leading: Image.asset(AppImage.logout,
          width: WidgetSize.drawerIcon, height: WidgetSize.drawerIcon),
      title: Text(
        AppText.logout,
        style: AppTextStyle.getNavigationBarItemTextStyle(false),
      ),
      onTap: _onLogoutTap,
      selectedColor: AppColors.primary,
      focusColor: AppColors.primary,
    );
  }
}
