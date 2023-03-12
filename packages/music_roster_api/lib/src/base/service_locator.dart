import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:music_roster_api/src/helpers/app_helper.dart';
import 'package:music_roster_api/models/app_message.dart';
import 'package:music_roster_api/src/helpers/app_shared_pref.dart';

final getIt = GetIt.instance;

Future<void> setupLocator(FirebaseOptions? options) async {
  var appSharedPref = await AppSharedPref.getInstance();
  var appHelper = await AppHelper.getInstance();
  getIt.registerSingleton(appHelper);

  await appSharedPref.initSetup();
  await appHelper.initSetup();

  await Firebase.initializeApp(options: options).onError(
      (error, stackTrace) => AppMessage.errorMessage(error.toString()));

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton<AppSharedPref>(appSharedPref);
}
