import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';

enum UserRole {
  piano,
  lead,
  drums,
  guitar,
  bass,
  vocal,
  cajon,
  violin,
  pa;

  Color get color {
    switch (this) {
      case UserRole.piano:
        return Colors.yellow;
      case UserRole.lead:
        return Colors.brown;
      case UserRole.drums:
        return Colors.red;
      case UserRole.guitar:
        return Colors.lightBlue;
      case UserRole.bass:
        return Colors.blue;
      case UserRole.vocal:
        return Colors.pink;
      case UserRole.cajon:
        return Colors.orange;
      case UserRole.violin:
        return Colors.indigo;
      case UserRole.pa:
        return Colors.teal;
    }
  }

  String get name {
    switch (this) {
      case UserRole.piano:
        return AppText.piano;
      case UserRole.lead:
        return AppText.lead;
      case UserRole.drums:
        return AppText.drums;
      case UserRole.guitar:
        return AppText.guitar;
      case UserRole.bass:
        return AppText.bass;
      case UserRole.vocal:
        return AppText.vocal;
      case UserRole.cajon:
        return AppText.cajon;
      case UserRole.violin:
        return AppText.voilin;
      case UserRole.pa:
        return AppText.pa;
    }
  }

  String get type {
    switch (this) {
      case UserRole.piano:
        return 'musician';
      case UserRole.lead:
        return 'musician';
      case UserRole.drums:
        return 'musician';
      case UserRole.guitar:
        return 'musician';
      case UserRole.bass:
        return 'musician';
      case UserRole.vocal:
        return 'musician';
      case UserRole.cajon:
        return 'musician';
      case UserRole.violin:
        return 'musician';
      case UserRole.pa:
        return 'others';
    }
  }

  static UserRole? getUserRoleFromString(String name) {
    return UserRole.values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase());
  }
}
