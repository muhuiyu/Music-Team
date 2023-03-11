import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';

class AppDecoration {
  static BoxDecoration pageGrid = BoxDecoration(
    border: Border.all(color: AppColors.lightGrey),
    borderRadius: BorderRadius.circular(4),
  );

  static BoxDecoration callout = BoxDecoration(
      border: Border.all(style: BorderStyle.solid, color: AppColors.lightGrey),
      borderRadius: BorderRadius.circular(4),
      color: AppColors.white);

  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: AppColors.lightGrey, width: 1),
  );
}
