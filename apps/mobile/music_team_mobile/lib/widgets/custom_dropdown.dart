import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';

enum CustomDropDownTitlePosition { top, left }

// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  List<String> items;
  final String title;
  String value;
  CustomDropDownTitlePosition titlePosition;

  final void Function(String) onChanged;

  CustomDropDown({
    super.key,
    required this.items,
    required this.title,
    this.value = '',
    required this.onChanged,
    this.titlePosition = CustomDropDownTitlePosition.top,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String _selectedValue = '';

  @override
  void initState() {
    _updateSelectedValue();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedValue();
  }

  void _updateSelectedValue() {
    if (widget.items.isEmpty) return;
    if (widget.value.isEmpty) {
      _selectedValue = widget.items.first;
      return;
    }

    if (widget.items.contains(widget.value)) {
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget dropdown = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
        color: AppColors.white,
      ),
      child: DropdownButton<String>(
        value: _selectedValue,
        style: AppTextStyle.dropdownText,
        underline: Container(),
        items: widget.items.toSet().toList().map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 20),
              child: Text(item, style: AppTextStyle.dropdownText),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue ?? '';
          });
          widget.onChanged(newValue ?? '');
        },
      ),
    );

    switch (widget.titlePosition) {
      case CustomDropDownTitlePosition.top:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: AppTextStyle.dropdownFieldName),
            const SizedBox(height: 8),
            dropdown
          ],
        );
      case CustomDropDownTitlePosition.left:
        return Row(children: [
          Text(
            widget.title,
            style: AppTextStyle.dropdownText,
          ),
          const SizedBox(width: 12),
          dropdown
        ]);
    }
  }
}
