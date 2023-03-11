import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/modules/common/widgets/search_bar.dart';

class OptionList extends StatefulWidget {
  final List<String> items;
  final String title;
  final Set<String> selectedItems;
  final void Function(List<String> items) onChanged;
  final bool allowMultipleSelection;
  final bool isSearchEnabled;

  const OptionList({
    super.key,
    required this.items,
    required this.title,
    required this.selectedItems,
    required this.onChanged,
    this.allowMultipleSelection = true,
    this.isSearchEnabled = false,
  });

  @override
  State<OptionList> createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  late Set<String> _selectedItems = {};
  @override
  void initState() {
    _selectedItems = widget.selectedItems.toSet();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OptionList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedItems = widget.selectedItems.toSet();
  }

  _showOptionListDialog() async {
    final Set<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return OptionListDialog(
          items: widget.items,
          selectedItems: _selectedItems,
          title: widget.title,
          isSearchEnabled: widget.isSearchEnabled,
          allowMultipleSelection: widget.allowMultipleSelection,
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
      widget.onChanged(_selectedItems.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget dropdown = GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
          color: AppColors.white,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 8),
          child: Row(
            children: [
              Text(
                  _selectedItems.isEmpty
                      ? '-'
                      : _selectedItems
                          .toList()
                          // .sort((a, b) =>
                          //     a.toLowerCase().compareTo(b.toLowerCase()))
                          .join(', '),
                  style: AppTextStyle.dropdownText),
              const Spacer(),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.label,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptionListDialog();
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTextStyle.dropdownFieldName),
        const SizedBox(height: 8),
        dropdown
      ],
    );
  }
}

class OptionListDialog extends StatefulWidget {
  final List<String> items;
  final String title;
  final Set<String> selectedItems;
  final bool isSearchEnabled;
  final bool allowMultipleSelection;
  const OptionListDialog({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.isSearchEnabled,
    required this.allowMultipleSelection,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OptionListDialogState();
}

class _OptionListDialogState extends State<OptionListDialog> {
  late List<String> _displayingItems = [];
  late Set<String> _selectedItems = {};
  late TextEditingController _editingController;

  @override
  void initState() {
    _selectedItems = widget.selectedItems.toSet();
    _displayingItems = widget.items;
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
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

  _singleItemChange(String? itemValue) {
    if (itemValue == null) return;
    setState(() {
      _selectedItems = {itemValue};
    });
  }

  _cancel() {
    Navigator.pop(context);
  }

  _submit() {
    Navigator.pop(context, _selectedItems);
  }

  _filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayingItems = widget.items;
      } else {
        _displayingItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      scrollable: true,
      content: Column(
        children: [
          if (widget.isSearchEnabled)
            SearchBar(
                editingController: _editingController,
                onChanged: _filterSearchResults),
          if (widget.isSearchEnabled) Paddings.cardGridInlineSpacingBox,
          SingleChildScrollView(
            child: ListBody(
              children: widget.allowMultipleSelection
                  ? _displayingItems
                      .map((item) => RadioListTile(
                          value: item,
                          title: Text(item),
                          groupValue: _selectedItems.first,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) => _singleItemChange(value)))
                      .toList()
                  : _displayingItems
                      .map((item) => CheckboxListTile(
                            value: _selectedItems.contains(item),
                            title: Text(item),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (isChecked) =>
                                _itemChange(item, isChecked!),
                          ))
                      .toList(),
            ),
          ),
        ],
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
