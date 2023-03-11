import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:music_team_admin/api/src/token_model.dart';
import 'package:music_team_admin/base/base_provider.dart';
import 'package:music_team_admin/router/router.dart';
import 'package:music_team_admin/widgets/custom_snack_bar.dart';

class AuthProvider extends BaseProvider {
  String authToken = '';
  String deviceToken = 'isWeb';

  /// Restore Previous Session
  Future<User?> restorePreviousSession() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    bool isSignedIn = await googleSignIn.isSignedIn();
    return isSignedIn ? FirebaseAuth.instance.currentUser : null;
  }

  /// Sign in
  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      return _signInWithGoogleFromWeb(context: context);
    } else {
      return _signInWithGoogleFromMobile(context: context);
    }
  }

  Future<User?> _signInWithGoogleFromWeb(
      {required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<User?> _signInWithGoogleFromMobile(
      {required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return null;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    // TODO: add change here
    // pref.token = TokenModel(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     userId: googleSignInAuthentication.idToken);

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          getCustomSnackBar(
              'The account already exists with a different credential.'),
        );
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          getCustomSnackBar(
              'Error occurred while accessing credentials. Try again.'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        getCustomSnackBar('Error occurred using Google Sign-In. Try again.'),
      );
    }

    return user;
  }

  /// Sign out
  Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        getCustomSnackBar('Error signing out. Try again.'),
      );
    }
  }

  // Example : API calling
  Future<String?> getUserProfile() async {
    pref.token = TokenModel(userId: 2315, accessToken: 'some-token');

    // TODO: connect to real data
    // try {
    //   Dio dio = Dio();
    //   dio.options.headers['Authorization'] = 'Bearer $authToken';
    //   final response = await dio.get('https://graph.microsoft.com/v1.0/me/');
    //   if (response.statusCode == 200) {
    //     if (response.data['mail'] == null) {
    //       return response.data['userPrincipalName'];
    //     } else {
    //       return response.data['mail'];
    //     }
    //   }
    //   hideLoadingIndicator();
    //   return null;
    // } on DioError {
    //   hideLoadingIndicator();
    //   rethrow;
    // }
  }

  void removeLoginData() async {
    pref.removeLoginDetails();
    Get.Get.offAndToNamed(Routes.loginScreen);
  }
}
