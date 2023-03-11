import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';

enum ListTileType {
  first,
  last,
  only,
  other;

  static ListTileType configureType(int index, int totalNumber) {
    if (index == 0) {
      return totalNumber == 1 ? only : first;
    } else if (index == totalNumber - 1) {
      return last;
    } else {
      return other;
    }
  }
}

// ignore: must_be_immutable
class PageCardGrid extends StatelessWidget {
  Widget child;
  ListTileType type;
  bool isSeparatorHidden;

  PageCardGrid({
    super.key,
    required this.child,
    this.type = ListTileType.other,
    this.isSeparatorHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration separator = const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lightGrey)));
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      title: Container(
        padding: Paddings.cardGrid,
        decoration: (isSeparatorHidden || type == ListTileType.first)
            ? null
            : separator,
        child: child,
      ),
    );
  }
}
