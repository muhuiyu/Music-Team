import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_roster_api/music_roster_api.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatefulWidget {
  final Function(User) onVerifySucceed;
  const GoogleSignInButton({super.key, required this.onVerifySucceed});

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _isSigningIn
            ? _renderCircularProgressIndicator()
            : _renderButton());
  }

  Widget _renderCircularProgressIndicator() {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
    );
  }

  _onButtonPressed() async {
    setState(() {
      _isSigningIn = true; // Loading
    });

    User? user = await Provider.of<AuthProvider>(context, listen: false)
        .signInWithGoogle(context: context);

    setState(() {
      _isSigningIn = false;
    });

    if (user != null) {
      widget.onVerifySucceed(user);
    }
  }

  Widget _renderButton() {
    return CustomTextButton(
      imageName: AppImage.googleLogo,
      text: AppText.googleLoginButtonText,
      onPressed: () {
        _onButtonPressed();
      },
      type: CustomButtonType.primaryWhite,
      textColor: AppColors.label,
    );
  }
}
