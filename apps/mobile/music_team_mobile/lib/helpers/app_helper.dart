import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppHelper {
  static late AndroidDeviceInfo _androidInfo;
  static late IosDeviceInfo _iosInfo;
  static late PackageInfo packageInfo;

  AppHelper._privateConstructor();
  static final AppHelper instance = AppHelper._privateConstructor();

  static Future<AppHelper> getInstance() async {
    return AppHelper.instance;
  }

  initSetup() async {
    if (Platform.isAndroid) {
      _androidInfo = await DeviceInfoPlugin().androidInfo;
    } else if (Platform.isIOS) {
      _iosInfo = await DeviceInfoPlugin().iosInfo;
    }
    packageInfo = await PackageInfo.fromPlatform();
  }

  bool getMockDataStatus() {
    return true;
  }

  String getDevicePlatform() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    }
    return '';
  }

  String getDeviceModel() {
    if (Platform.isAndroid) {
      final String manufacturer = _androidInfo.manufacturer;
      final String model = _androidInfo.model;
      return '$manufacturer $model';
    } else if (Platform.isIOS) {
      final String? name = _iosInfo.utsname.machine;
      return '$name';
    }
    return '';
  }

  String getVersionNumber() {
    return packageInfo.version;
  }

  String getBuildNumber() {
    return packageInfo.buildNumber;
  }

  bool isTablet(BuildContext context) {
    if (Platform.isIOS) {
      return _iosInfo.model?.toLowerCase() == "ipad";
    } else {
      // The equivalent of the "smallestWidth" qualifier on Android.
      var shortestSide = MediaQuery.of(context).size.shortestSide;
      // Determine if we should use mobile layout or not, 600 here is
      // a common breakpoint for a typical 7-inch tablet.
      return shortestSide > 600;
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
