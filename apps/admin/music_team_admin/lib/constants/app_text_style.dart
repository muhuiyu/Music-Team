import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';

class AppTextStyle {
  // Cards
  static TextStyle get cardTitle {
    return getTextStyle(AppFont.h3, AppColors.label,
        weight: TextStyleWeight.bold);
  }

  static TextStyle get cardSubtitle {
    return getTextStyle(AppFont.body, AppColors.secondaryLabel);
  }

  // Tables
  static TextStyle get tableHeader {
    return getTextStyle(AppFont.body, AppColors.label,
        weight: TextStyleWeight.bold);
  }

  static TextStyle get tableContent {
    return getTextStyle(AppFont.body, AppColors.label);
  }

  // Card grids
  static TextStyle get cardGridTitle {
    return getTextStyle(AppFont.body, AppColors.label,
        weight: TextStyleWeight.medium);
  }

  static TextStyle get cardGridTitleWithBackground {
    return getTextStyle(AppFont.body, AppColors.darkGrey,
        weight: TextStyleWeight.medium);
  }

  static TextStyle get cardGridSubtitle {
    return getTextStyle(AppFont.body, AppColors.secondaryLabel);
  }

  static TextStyle get cardGridSubtitleDisabled {
    return getTextStyle(AppFont.body, AppColors.tertiaryLabel);
  }

  static TextStyle get cardGridSideNote {
    return getTextStyle(AppFont.desc, AppColors.tertiaryLabel);
  }

  // Upcoming service card
  static TextStyle get cardSectionTitle {
    return getTextStyle(AppFont.body, AppColors.secondaryLabel,
        weight: TextStyleWeight.bold);
  }

  static TextStyle get cardSectionText {
    return getTextStyle(AppFont.body, AppColors.label);
  }

  // Service details
  static TextStyle get serviceDetailsSubtitle {
    return getTextStyle(AppFont.small, AppColors.tertiaryLabel,
        weight: TextStyleWeight.heavy);
  }

  // TextFields
  static TextStyle get textFieldText {
    return getTextStyle(AppFont.body, AppColors.label);
  }

  static TextStyle get textFieldPlaceholder {
    return getTextStyle(AppFont.body, AppColors.tertiaryLabel);
  }

  // Page
  static TextStyle get pageHeader {
    return getTextStyle(AppFont.h2, AppColors.label,
        weight: TextStyleWeight.bold);
  }

  static TextStyle get calloutText {
    return getTextStyle(AppFont.small, AppColors.secondaryLabel);
  }

  static TextStyle get calloutHighlight {
    return getTextStyle(AppFont.small, AppColors.secondaryLabel,
        weight: TextStyleWeight.bold);
  }

  // Dropdown
  static TextStyle get dropdownText {
    return getTextStyle(AppFont.body, AppColors.label);
  }

  static TextStyle get dropdownFieldName {
    return getTextStyle(AppFont.small, AppColors.tertiaryLabel,
        weight: TextStyleWeight.bold);
  }

  // Navigation bar
  static TextStyle getNavigationBarItemTextStyle(bool isSelected) {
    // return getTextStyle(
    //     AppFont.body, isSelected ? AppColors.label : AppColors.white);
    return getTextStyle(AppFont.body, AppColors.white);
  }

  // Button
  static TextStyle getButtonTextStyle(Color color) {
    return getTextStyle(AppFont.body, color, weight: TextStyleWeight.medium);
  }

  static TextStyle get navigationButtonTextStyle {
    return getTextStyle(AppFont.body, AppColors.white,
        weight: TextStyleWeight.bold);
  }

  static TextStyle get textButtonTextStyle {
    return getTextStyle(AppFont.body, AppColors.primary,
        weight: TextStyleWeight.bold);
  }

  // other methods
  static TextStyle getTextStyle(AppFont font, Color color,
      {TextStyleWeight weight = TextStyleWeight.normal}) {
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
        return 36;
      case AppFont.h2:
        return 32;
      case AppFont.h3:
        return 22;
      case AppFont.h4:
        return 20;
      case AppFont.body:
        return 16;
      case AppFont.small:
        return 14;
      case AppFont.desc:
        return 12;
    }
  }
}
