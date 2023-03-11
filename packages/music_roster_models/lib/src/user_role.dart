import 'package:flutter/material.dart';
import 'package:music_roster_admin/constants/constants.dart';

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

  String get key {
    switch (this) {
      case UserRole.piano:
        return AppText.piano.toLowerCase();
      case UserRole.lead:
        return AppText.lead.toLowerCase();
      case UserRole.drums:
        return AppText.drums.toLowerCase();
      case UserRole.guitar:
        return AppText.guitar.toLowerCase();
      case UserRole.bass:
        return AppText.bass.toLowerCase();
      case UserRole.vocal:
        return AppText.vocal.toLowerCase();
      case UserRole.cajon:
        return AppText.cajon.toLowerCase();
      case UserRole.violin:
        return AppText.voilin.toLowerCase();
      case UserRole.pa:
        return AppText.pa.toLowerCase();
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

  IconData get iconData {
    switch (this) {
      case UserRole.piano:
        return Icons.piano;
      case UserRole.lead:
        return Icons.music_note;
      case UserRole.drums:
        return Icons.mic;
      case UserRole.guitar:
        return Icons.music_note;
      case UserRole.bass:
        return Icons.music_note;
      case UserRole.vocal:
        return Icons.mic;
      case UserRole.cajon:
        return Icons.add_box;
      case UserRole.violin:
        return Icons.music_note;
      case UserRole.pa:
        return Icons.headphones;
    }
  }

  static UserRole? getUserRoleFromString(String name) {
    return UserRole.values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase());
  }
}
