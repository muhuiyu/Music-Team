import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:music_team_admin/widgets/custom_button.dart';
import 'package:music_team_admin/widgets/custom_textfield.dart';

class EditMemberDialog extends StatefulWidget {
  final UserModel user;
  const EditMemberDialog({super.key, required this.user});

  @override
  State<EditMemberDialog> createState() => _EditMemberDialogState();
}

class _EditMemberDialogState extends State<EditMemberDialog> {
  final List<MultiSelectItem> _roleOptions = UserRole.values
      .map((role) => MultiSelectItem<UserRole>(role, role.name))
      .toList();
  late UserModel _user;
  late List<UserRole> _selectedRoles;
  late TextEditingController _nameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _phoneEditingController;

  bool _isSaveButtonEnabled = false;

  _onSaveButtonPressed() {
    UserModel updatedUser = _user;
    updatedUser.name = _nameEditingController.text;
    updatedUser.email = _emailEditingController.text;
    updatedUser.phone = _phoneEditingController.text;
    updatedUser.roles = _selectedRoles;
    Navigator.pop(context, updatedUser);
  }

  _onCancelButtonPressed() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _nameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _phoneEditingController = TextEditingController();
    _nameEditingController.text = _user.name;
    _emailEditingController.text = _user.email;
    _phoneEditingController.text = _user.phone;
    _selectedRoles = _user.roles;

    _nameEditingController.addListener(() {
      _configureSaveButton();
    });
    _emailEditingController.addListener(() {
      _configureSaveButton();
    });
    _phoneEditingController.addListener(() {
      _configureSaveButton();
    });
  }

  _configureSaveButton() {
    setState(() {
      if (_nameEditingController.text != _user.name) {
        _isSaveButtonEnabled = true;
      } else if (_emailEditingController.text != _user.email) {
        _isSaveButtonEnabled = true;
      } else if (_phoneEditingController.text != _user.phone) {
        _isSaveButtonEnabled = true;
      } else if (_selectedRoles != _user.roles) {
        _isSaveButtonEnabled = true;
      } else {
        _isSaveButtonEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(AppText.editing, style: AppTextStyle.cardGridSubtitle),
          const SizedBox(height: 12),
          Text(AppText.editMemberTitle, style: AppTextStyle.cardTitle),
          const SizedBox(height: 24),
        ],
      ),
      content: SizedBox(
        width: 800,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
                editingController: _nameEditingController, title: AppText.name),
            Paddings.inlineSpacingBox,
            CustomTextField(
                editingController: _emailEditingController,
                title: AppText.email),
            Paddings.inlineSpacingBox,
            CustomTextField(
                editingController: _phoneEditingController,
                title: AppText.phone),
            Paddings.inlineSpacingBox,
            _renderRolesMultiSelect(),
            const SizedBox(height: 48),
          ],
        ),
      ),
      actions: [
        CustomButton(
            onPressed: _onCancelButtonPressed,
            type: CustomButtonType.primaryGrey,
            child: Text(AppText.cancel,
                style: AppTextStyle.getButtonTextStyle(AppColors.label))),
        CustomButton(
            onPressed: _onSaveButtonPressed,
            isEnabled: _isSaveButtonEnabled,
            type: CustomButtonType.primary,
            child: Text(AppText.save,
                style: AppTextStyle.getButtonTextStyle(AppColors.white))),
      ],
    );
  }

  _configureRoles(List<dynamic> values) {
    List<UserRole> roles = [];
    for (final value in values) {
      roles.add(value as UserRole);
    }
    setState(() {
      _selectedRoles = roles;
      if (_selectedRoles != _user.roles) {
        _isSaveButtonEnabled = true;
      }
    });
  }

  _renderRolesMultiSelect() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppText.roles, style: AppTextStyle.dropdownFieldName),
        const SizedBox(height: 12),
        MultiSelectChipField(
          items: _roleOptions,
          initialValue: _user.roles,
          title: Text(
            _selectedRoles.map((e) => e.name).join(', '),
            style: AppTextStyle.textFieldText,
          ),
          headerColor: AppColors.accent,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.accent),
            borderRadius: BorderRadius.circular(4),
          ),
          selectedChipColor: AppColors.primary.withOpacity(0.5),
          selectedTextStyle:
              AppTextStyle.getTextStyle(AppFont.small, AppColors.primary),
          onTap: (values) {
            _configureRoles(values);
          },
        ),
      ],
    );
  }
}
