import 'package:flutter/material.dart';
import 'package:music_team_mobile/constants/constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String title;
  String value;
  String placeholder;
  Function(String) onChanged;

  CustomTextField({
    super.key,
    required this.title,
    this.value = '',
    this.placeholder = 'Enter...',
    required this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editingController.text = widget.value;
    editingController.addListener(() {
      widget.onChanged(editingController.text);
    });
  }

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
        Text(widget.title, style: AppTextStyle.dropdownFieldName),
        const SizedBox(height: 12),
        TextField(
          style: AppTextStyle.textFieldText,
          controller: editingController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            filled: true,
            fillColor: AppColors.accent,
            hintText: widget.placeholder,
            hintStyle: AppTextStyle.textFieldPlaceholder,
            enabledBorder: inputBorder,
            border: inputBorder,
            focusedBorder: inputBorder,
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}
