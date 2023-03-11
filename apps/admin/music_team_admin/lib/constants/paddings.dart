import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/widget_size.dart';

class Paddings {
  static const EdgeInsets safeArea =
      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0);

  static const EdgeInsets pageHeader =
      EdgeInsets.symmetric(vertical: 24, horizontal: 24);
  static const EdgeInsets card =
      EdgeInsets.symmetric(vertical: 12, horizontal: 20);
  static const EdgeInsets callout =
      EdgeInsets.symmetric(vertical: 16, horizontal: 20);
  static const EdgeInsets cardGrid = EdgeInsets.all(16);

  /// SizedBox(height: 24)
  static const Widget inlineSpacingBox = SizedBox(height: 24);
  static const Widget cardGridInlineSpacingBox = SizedBox(height: 12);
  static const EdgeInsets appBarTextButton = EdgeInsets.all(12);
  static const Widget cardGridInlineParagraphSpacingBox = SizedBox(height: 8);

  static const EdgeInsets drawerHeader = EdgeInsets.symmetric(vertical: 36);

  /// SizedBox(height: 24)
  static const SizedBox drawerBottomSpacingBox = SizedBox(height: 24);

  /// SizedBox(height: 24, width: 24)
  static SizedBox drawerIcon =
      SizedBox(height: WidgetSize.drawerIcon, width: WidgetSize.drawerIcon);
  static const EdgeInsets drawerListTile =
      EdgeInsets.symmetric(horizontal: 24, vertical: 4);

  // expansionTile
  static const EdgeInsets expansionTilePadding =
      EdgeInsets.only(top: 16, bottom: 12, left: 20, right: 20);
  static const EdgeInsets expansionChildrenPadding =
      EdgeInsets.only(bottom: 24, left: 20, right: 20);

  static const SizedBox cardHeaderInlineSpacing = SizedBox(height: 8);
  static const EdgeInsets cardChild =
      EdgeInsets.symmetric(vertical: 24, horizontal: 20);

  static const SizedBox calloutSpacingBox = SizedBox(width: 16);
}
