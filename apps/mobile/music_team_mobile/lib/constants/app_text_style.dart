import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';

class AppTextStyle {
  // Tabbar
  static TextStyle get tabbarItem {
    return getTextStyle(AppFont.body, weight: TextStyleWeight.bold);
  }

  // Cards
  static TextStyle get cardTitle {
    return getTextStyle(AppFont.h3,
        color: AppColors.label, weight: TextStyleWeight.bold);
  }

  static TextStyle get cardSubtitle {
    return getTextStyle(AppFont.body, color: AppColors.secondaryLabel);
  }

  // Card grids
  static TextStyle get cardGridTitle {
    return getTextStyle(AppFont.body,
        color: AppColors.label, weight: TextStyleWeight.medium);
  }

  static TextStyle get cardGridTitleWithBackground {
    return getTextStyle(AppFont.body,
        color: AppColors.darkGrey, weight: TextStyleWeight.medium);
  }

  static TextStyle get cardGridSubtitle {
    return getTextStyle(AppFont.body, color: AppColors.secondaryLabel);
  }

  static TextStyle get cardGridSubtitleDisabled {
    return getTextStyle(AppFont.body, color: AppColors.tertiaryLabel);
  }

  static TextStyle get cardGridSideNote {
    return getTextStyle(AppFont.desc, color: AppColors.tertiaryLabel);
  }

  // TextFields
  static TextStyle get textFieldText {
    return getTextStyle(AppFont.body, color: AppColors.label);
  }

  static TextStyle get textFieldPlaceholder {
    return getTextStyle(AppFont.body, color: AppColors.tertiaryLabel);
  }

  // Page
  static TextStyle get pageHeader {
    return getTextStyle(AppFont.h2,
        color: AppColors.label, weight: TextStyleWeight.bold);
  }

  static TextStyle get calloutText {
    return getTextStyle(AppFont.small, color: AppColors.secondaryLabel);
  }

  static TextStyle get calloutHighlight {
    return getTextStyle(AppFont.small,
        color: AppColors.secondaryLabel, weight: TextStyleWeight.bold);
  }

  // Dropdown
  static TextStyle get dropdownText {
    return getTextStyle(AppFont.body, color: AppColors.label);
  }

  static TextStyle get dropdownFieldName {
    return getTextStyle(AppFont.small,
        color: AppColors.tertiaryLabel, weight: TextStyleWeight.bold);
  }

  // Navigation bar
  static TextStyle getNavigationBarItemTextStyle(bool isSelected) {
    return getTextStyle(AppFont.body,
        color: isSelected ? AppColors.label : AppColors.white);
  }

  // Button
  static TextStyle getButtonTextStyle(Color? color) {
    return getTextStyle(AppFont.body,
        color: color, weight: TextStyleWeight.medium);
  }

  static TextStyle get navigationButtonTextStyle {
    return getTextStyle(AppFont.body,
        color: AppColors.white, weight: TextStyleWeight.bold);
  }

  static TextStyle get textButtonTextStyle {
    return getTextStyle(AppFont.body,
        color: AppColors.primary, weight: TextStyleWeight.bold);
  }

  // calendar
  static TextStyle get calendarHeader {
    return getTextStyle(AppFont.small,
        color: AppColors.label, weight: TextStyleWeight.bold);
  }

  static TextStyle get calendarText {
    return getTextStyle(AppFont.small, color: AppColors.label);
  }

  // other methods
  static TextStyle getTextStyle(AppFont font,
      {Color? color, TextStyleWeight weight = TextStyleWeight.normal}) {
    return TextStyle(
        fontSize: font.fontSize, color: color, fontWeight: weight.fontWeight);
  }
}

enum TextStyleWeight { light, normal, medium, bold, heavy }

extension TextStyleWeightExtension on TextStyleWeight {
  FontWeight get fontWeight {
    switch (this) {
      case TextStyleWeight.light:
        return FontWeight.w200;
      case TextStyleWeight.normal:
        return FontWeight.normal;
      case TextStyleWeight.medium:
        return FontWeight.w500;
      case TextStyleWeight.bold:
        return FontWeight.bold;
      case TextStyleWeight.heavy:
        return FontWeight.w900;
    }
  }
}

enum AppFont { h1, h2, h3, h4, body, small, desc }

extension AppFontExtension on AppFont {
  double get fontSize {
    switch (this) {
      case AppFont.h1:
        return 32;
      case AppFont.h2:
        return 24;
      case AppFont.h3:
        return 20;
      case AppFont.h4:
        return 18;
      case AppFont.body:
        return 16;
      case AppFont.small:
        return 14;
      case AppFont.desc:
        return 12;
    }
  }
}
