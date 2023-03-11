import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final Function(bool)? onExpansionChanged;
  final EdgeInsets? tilePadding;
  final EdgeInsets? childrenPadding;
  final Color? iconColor;
  final Color? collapsedIconColor;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
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
