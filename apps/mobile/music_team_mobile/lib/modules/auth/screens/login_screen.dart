import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/api/providers/auth_provider.dart';
import 'package:music_team_mobile/modules/account/account_screen.dart';
import 'package:music_team_mobile/modules/auth/widgets/google_login_button.dart';
import 'package:music_team_mobile/router/router.dart';
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
    // check if user is signed in
    final user = await _authProvider.restorePreviousSession();
    if (user != null) {
      Get.toNamed(Routes.accountScreen,
          arguments: Routes.accountArgument(user));
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => AccountScreen(
      //       user: user,
      //     ),
      //   ),
      // );
    }
    // _auth = FirebaseAuth.instanceFor(app: defaultApp);
    // // immediately check whether the user is signed in
    // checkIfUserIsSignedIn();
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
              const Row(),
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
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => AccountScreen(),
    //   ),
    // );
  }
}
