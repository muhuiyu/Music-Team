import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatelessWidget {
  Widget title;
  List<Widget> children;
  bool initiallyExpanded;
  Function(bool)? onExpansionChanged;
  EdgeInsets? tilePadding;
  EdgeInsets? childrenPadding;
  Color? iconColor;
  Color? collapsedIconColor;

  CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.tilePadding,
    this.childrenPadding,
    this.iconColor,
    this.collapsedIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        title: title,
        initiallyExpanded: initiallyExpanded,
        shape: null,
        onExpansionChanged: onExpansionChanged,
        tilePadding: tilePadding,
        childrenPadding: childrenPadding,
        iconColor: iconColor,
        collapsedIconColor: collapsedIconColor,
        children: children,
      ),
    );
  }
}
