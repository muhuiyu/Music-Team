import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_team_mobile/extensions/color_extensions.dart';

class AppColors {
  static const Color primary = Colors.indigo;
  static const Color secondary = Colors.black38;

  // error
  static Color error = Colors.red;

  static Color darkBlue = HexColor.fromHex('23293A');

  static const Color white = Colors.white;
  static const Color lightGrey = CupertinoColors.systemGrey4;
  static Color accent = HexColor.fromHex('F5F6F7');
  static Color grey = HexColor.fromHex('94A9BB');
  static Color darkGrey = HexColor.fromHex('61778A');

  // label and text
  // static const Color label = CupertinoColors.label;
  // static const Color secondaryLabel = CupertinoColors.secondaryLabel;
  // static const Color tertiaryLabel = CupertinoColors.tertiaryLabel;
  static Color label = AppColors.darkBlue;
  static Color secondaryLabel = AppColors.darkGrey;
  static Color tertiaryLabel = AppColors.grey;

  // background
  static const Color background = CupertinoColors.systemBackground;
  static const Color secondarySystemBackground =
      CupertinoColors.secondarySystemBackground;
  static const Color lightBackgroundGray = CupertinoColors.lightBackgroundGray;
  static const Color extraLightBackgroundGray =
      CupertinoColors.extraLightBackgroundGray;

  static const Color inactiveGrayBackground = Color.fromARGB(70, 207, 207, 207);
  static const Color darkBackgroundGray = CupertinoColors.darkBackgroundGray;

  // kpi
  static Color red = Colors.red;
  static Color kpiGreen = Colors.green;
  static Color kpiAmber = Colors.amber;

  // Firebase and Google
  static final Color firebaseNavy = Color(0xFF2C384A);
  static final Color firebaseOrange = Color(0xFFF57C00);
  static final Color firebaseAmber = Color(0xFFFFA000);
  static final Color firebaseYellow = Color(0xFFFFCA28);
  static final Color firebaseGrey = Color(0xFFECEFF1);
  static final Color googleBackground = Color(0xFF4285F4);
}
