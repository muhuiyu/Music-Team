import 'package:flutter/material.dart';

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
        return 'piano';
      case UserRole.lead:
        return 'lead';
      case UserRole.drums:
        return 'drums';
      case UserRole.guitar:
        return 'guitar';
      case UserRole.bass:
        return 'bass';
      case UserRole.vocal:
        return 'vocal';
      case UserRole.cajon:
        return 'cajon';
      case UserRole.violin:
        return 'voilin';
      case UserRole.pa:
        return 'pa';
    }
  }

  String get key {
    switch (this) {
      case UserRole.piano:
        return 'piano';
      case UserRole.lead:
        return 'lead';
      case UserRole.drums:
        return 'drums';
      case UserRole.guitar:
        return 'guitar';
      case UserRole.bass:
        return 'bass';
      case UserRole.vocal:
        return 'vocal';
      case UserRole.cajon:
        return 'cajon';
      case UserRole.violin:
        return 'voilin';
      case UserRole.pa:
        return 'pa';
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
