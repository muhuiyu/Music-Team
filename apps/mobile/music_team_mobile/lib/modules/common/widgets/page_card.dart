import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_expansion_tile.dart';

// ignore: must_be_immutable
class PageCard extends StatelessWidget {
  String title;
  String? subtitle;
  Widget? child;
  bool isExpansionCard;
  bool initiallyExpanded;

  String? footerButtonText;
  Function()? onFooterButtonPressed;

  PageCard({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
    this.isExpansionCard = false,
    this.initiallyExpanded = true,
    this.footerButtonText,
    this.onFooterButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.lightGrey,
      color: AppColors.white,
      child: _configureChildView(),
    );
  }

  Widget _configureChildView() {
    List<Widget> headers = [Text(title, style: AppTextStyle.cardTitle)];

    if (subtitle != null) {
      headers.addAll([
        Paddings.cardHeaderInlineSpacing,
        Text(subtitle!, style: AppTextStyle.cardSubtitle),
      ]);
    }

    Widget headerView = Container(
      color: AppColors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: headers),
    );

    List<Widget> widgets = (child == null) ? [] : [child!];

    if (footerButtonText != null) {
      widgets.addAll(
          [Paddings.inlineSpacingBox, _renderFooterButton(footerButtonText!)]);
    }

    if (isExpansionCard) {
      return CustomExpansionTile(
          title: headerView,
          tilePadding: Paddings.expansionTilePadding,
          childrenPadding: Paddings.expansionChildrenPadding,
          initiallyExpanded: initiallyExpanded, //Column
          iconColor: AppColors.secondaryLabel,
          collapsedIconColor: AppColors.secondaryLabel,
          children: widgets);
    } else {
      widgets.insertAll(0, [headerView, Paddings.inlineSpacingBox]);
      return Container(
        padding: Paddings.cardChild,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets),
      );
    }
  }

  _renderFooterButton(String title) {
    return TextButton(
      onPressed: onFooterButtonPressed,
      child: Text(title, style: AppTextStyle.textButtonTextStyle),
    );
  }
}
