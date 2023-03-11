import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';

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

class PageCardGrid extends StatelessWidget {
  final Widget child;
  final ListTileType type;
  final bool isSeparatorHidden;

  const PageCardGrid({
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
