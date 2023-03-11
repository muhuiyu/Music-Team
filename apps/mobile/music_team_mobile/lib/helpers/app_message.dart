import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

enum ToastType { success, failed }

class AppMessage {
  static errorMessage(String message) {
    showSimpleNotification(Text(message),
        leading: const Icon(Icons.warning_amber),
        background: Colors.red,
        position: NotificationPosition.bottom);
  }
}
