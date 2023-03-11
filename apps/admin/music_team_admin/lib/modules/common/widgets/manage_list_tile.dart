import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/modules/common/widgets/page_card_grid.dart';

class ManageListTile extends StatelessWidget {
  final String title;
  final Widget child;
  final ListTileType type;

  final Function() onEditButtonPressed;

  const ManageListTile({
    super.key,
    required this.title,
    required this.child,
    required this.onEditButtonPressed,
    this.type = ListTileType.other,
  });

  @override
  Widget build(BuildContext context) {
    return PageCardGrid(
      type: type,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Text(title, style: AppTextStyle.cardGridTitle),
              const Spacer(),
              SizedBox(
                height: WidgetSize.listTileButton,
                width: WidgetSize.listTileButton,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onEditButtonPressed,
                  icon: const Icon(Icons.edit),
                  iconSize: WidgetSize.listTileButton,
                ),
              ),
            ],
          ),
          Paddings.cardGridInlineSpacingBox,
          child
        ],
      ),
    );
  }
}
