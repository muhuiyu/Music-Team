import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/api/mock_data.dart';
import 'package:music_team_mobile/api/providers/auth_provider.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/models/user/user_model.dart';
import 'package:music_team_mobile/modules/auth/screens/login_screen.dart';
import 'package:music_team_mobile/modules/common/screens/base_screen.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_page.dart';
import 'package:music_team_mobile/router/router.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // TODO: add user
  late UserModel _user;
  bool _isSigningOut = false;

  Route _routeToLoginScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = testUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(currentScreen: ScreenName.account, widgets: [
      _user.photoUrl != null
          ? ClipOval(
              child: Material(
                color: AppColors.firebaseGrey.withOpacity(0.3),
                child: Image.network(
                  _user.photoUrl!,
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          : ClipOval(
              child: Material(
                color: AppColors.firebaseGrey.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.firebaseGrey,
                  ),
                ),
              ),
            ),
      SizedBox(height: 16.0),
      Text(
        'Hello',
        style: TextStyle(
          color: AppColors.firebaseGrey,
          fontSize: 26,
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        _user.name,
        style: TextStyle(
          color: AppColors.firebaseYellow,
          fontSize: 26,
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        '( ${_user.email} )',
        style: TextStyle(
          color: AppColors.firebaseOrange,
          fontSize: 20,
          letterSpacing: 0.5,
        ),
      ),
      SizedBox(height: 24.0),
      Text(
        'You are now signed in using your Google account. To sign out of your account, click the "Sign Out" button below.',
        style: TextStyle(
            color: AppColors.firebaseGrey.withOpacity(0.8),
            fontSize: 14,
            letterSpacing: 0.2),
      ),
      SizedBox(height: 16.0),
      _isSigningOut
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.redAccent,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await Provider.of<AuthProvider>(context, listen: false)
                    .signOut(context: context);
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(_routeToLoginScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
    ]);
  }
}
