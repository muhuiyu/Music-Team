import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_page.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  ScreenName currentScreen;
  Function()? onPressedBackButton;
  Function()? onPressedSaveButton;

  CustomAppBar({
    super.key,
    required this.currentScreen,
    this.onPressedBackButton,
    this.onPressedSaveButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        currentScreen.name,
        style: TextStyle(color: _configureTextColor()),
      ),
      backgroundColor: _configureBackgroundColor(),
      leading: _configureLeadingWidget(),
      actions: _configureActions(),
      shadowColor: _configureShadowColor(),
    );
  }

  Color _configureTextColor() {
    return currentScreen.pageType == CustomPageType.root
        ? AppColors.white
        : Colors.black;
  }

  Color? _configureShadowColor() {
    return currentScreen.pageType == CustomPageType.root
        ? null
        : Colors.transparent;
  }

  Color _configureBackgroundColor() {
    return currentScreen.pageType == CustomPageType.root
        ? AppColors.primary
        : AppColors.white;
  }

  Widget? _configureLeadingWidget() {
    switch (currentScreen.pageType) {
      case CustomPageType.root:
        return null;
      case CustomPageType.modal:
        return _renderCloseButton();
      case CustomPageType.sub:
        return _renderBackButton();
    }
  }

  List<Widget> _configureActions() {
    switch (currentScreen.action) {
      case CustomPageAction.save:
        return [
          TextButton(
            onPressed: onPressedSaveButton,
            child: _renderSaveButton(),
          )
        ];
      case CustomPageAction.notification:
        return [
          IconButton(
            onPressed: () {
              Get.to(ScreenName.notifications.widget,
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 250));
            },
            icon: _renderNotificationIcon(),
          )
        ];
      default:
        return [];
    }
  }

  _renderSaveButton() {
    return Padding(
      padding: Paddings.appBarTextButton,
      child: Text(
        AppText.save.toUpperCase(),
        style: AppTextStyle.navigationButtonTextStyle,
      ),
    );
  }

  _renderBackButton() {
    return IconButton(
      onPressed: onPressedBackButton,
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.white,
        size: WidgetSize.backButton,
      ),
    );
  }

  _renderCloseButton() {
    return IconButton(
      onPressed: onPressedBackButton,
      icon: Icon(
        Icons.close,
        color: AppColors.label,
        size: WidgetSize.appBarIcon,
      ),
    );
  }

  Widget _renderNotificationBadge() {
    return Container(
      width: 32,
      height: 32,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            width: 9,
            height: 9,
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 4, right: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderNotificationIcon() {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        children: [
          Icon(
            Icons.notifications,
            color: AppColors.white,
            size: WidgetSize.appBarNotificationIcon,
          ),
          _renderNotificationBadge(),
        ],
      ),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
