import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_roster_api/music_roster_api.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/router/router.dart';
import 'package:music_team_mobile/firebase_options.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/modules/common/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  // await dotenv.load(fileName: '.env');
  await setupLocator(DefaultFirebaseOptions.currentPlatform);

  return runZonedGuarded(() async {
    runApp(const TeamRoster());
  }, (error, stack) {
    if (kDebugMode) {
      print(stack);
      print(error);
    }
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class TeamRoster extends StatelessWidget {
  const TeamRoster({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return OverlaySupport.global(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppText.appName,
            routes: Routes.routes,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: LoaderView(
                  child: child!,
                ),
              );
            },
            home: MainScreen(
              currentScreen: ScreenName.serviceDetails,
            ),
            // home: const ServiceDetailsScreen(),
          ),
        );
      }),
    );
  }
}
