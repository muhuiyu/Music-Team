import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';

class MultiSelect extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItem;

  const MultiSelect({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  late List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItem;
  }

  _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  _cancel() {
    Navigator.pop(context);
  }

  _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text(AppText.cancel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text(AppText.save),
        ),
      ],
    );
  }
}
