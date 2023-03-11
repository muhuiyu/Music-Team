import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String title;
  final String placeholder;

  const CustomTextField({
    super.key,
    required this.editingController,
    required this.title,
    this.placeholder = 'Enter...',
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.accent, width: 1),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.dropdownFieldName),
        const SizedBox(height: 12),
        TextField(
          style: AppTextStyle.textFieldText,
          controller: editingController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            filled: true,
            fillColor: AppColors.accent,
            hintText: placeholder,
            hintStyle: AppTextStyle.textFieldPlaceholder,
            enabledBorder: inputBorder,
            border: inputBorder,
            focusedBorder: inputBorder,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
