import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  TextEditingController editingController;
  Function(String) onChanged;
  SearchBar({
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
