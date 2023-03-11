import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/api/providers/auth_provider.dart';
import 'package:music_team_admin/modules/auth/google_login_button.dart';
import 'package:music_team_admin/router/router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _initApp();
    });
  }

  _initApp() async {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = await _authProvider.restorePreviousSession();
    if (user != null) {
      Get.toNamed(Routes.accountScreen,
          arguments: Routes.accountArgument(user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.firebaseNavy,
      body: SafeArea(
        child: Padding(
          padding: Paddings.safeArea,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderLogoTitleView(),
              GoogleSignInButton(onVerifySucceed: (user) {
                _onVerifySucceed(user);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderLogoTitleView() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Image.asset(
              AppImage.appLogo,
              height: WidgetSize.loginScreenLogoSize,
            ),
          ),
          Paddings.inlineSpacingBox,
          Text(
            'Music Team Roster',
            style:
                AppTextStyle.getTextStyle(AppFont.h1, AppColors.firebaseYellow),
          ),
          Text(
            'St. George Church',
            style:
                AppTextStyle.getTextStyle(AppFont.h2, AppColors.firebaseOrange),
          ),
        ],
      ),
    );
  }

  _onVerifySucceed(User user) async {
    Get.toNamed(Routes.accountScreen, arguments: Routes.accountArgument(user));
  }
}
