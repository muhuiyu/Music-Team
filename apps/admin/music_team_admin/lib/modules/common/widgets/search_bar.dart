import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController editingController;
  final Function(String) onChanged;
  const SearchBar({
    super.key,
    required this.editingController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyle.textFieldPlaceholder,
      onChanged: (value) {
        onChanged(value);
      },
      controller: editingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        labelText: AppText.searchName,
        labelStyle: AppTextStyle.textFieldPlaceholder,
        suffixIcon: Icon(Icons.search, color: AppColors.tertiaryLabel),
        enabledBorder: AppDecoration.textFieldBorder,
        border: AppDecoration.textFieldBorder,
        focusedBorder: AppDecoration.textFieldBorder,
      ),
      maxLines: 1,
    );
  }
}
