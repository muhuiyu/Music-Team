import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:music_team_mobile/firebase_options.dart';
import 'package:music_team_mobile/helpers/app_message.dart';
import '../helpers/app_helper.dart';
import '../storage/app_shared_pref.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  var appSharedPref = await AppSharedPref.getInstance();
  var appHelper = await AppHelper.getInstance();
  getIt.registerSingleton(appHelper);

  await appSharedPref.initSetup();
  await appHelper.initSetup();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .onError(
          (error, stackTrace) => AppMessage.errorMessage(error.toString()));

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton<AppSharedPref>(appSharedPref);
  // getIt
  //     .registerSingleton<Dio>(NetworkModule.provideDio(getIt<AppSharedPref>()));
  // getIt.registerSingleton(DioClient(getIt<Dio>()));
  // getIt.registerSingleton(FirebaseClient(getIt<Dio>()));
}
