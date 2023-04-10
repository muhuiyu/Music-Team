import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:music_team_admin/widgets/custom_button.dart';
import 'package:music_team_admin/widgets/custom_textfield.dart';

class EditSongDialog extends StatefulWidget {
  final Song song;
  const EditSongDialog({super.key, required this.song});

  @override
  State<EditSongDialog> createState() => _EditSongDialogState();
}

class _EditSongDialogState extends State<EditSongDialog> {
  late Song _song;
  late TextEditingController _nameEditingController;
  late TextEditingController _authorEditingController;
  late TextEditingController _musicLinkEditingController;
  late TextEditingController _sheetLinkEditingController;

  bool _isSaveButtonEnabled = false;

  _onSaveButtonPressed() {
    Song song = _song;
    song.name = _nameEditingController.text;
    song.author = _authorEditingController.text;
    song.musicLinkString = _musicLinkEditingController.text;
    song.sheetLinkString = _sheetLinkEditingController.text;
    Navigator.pop(context, song);
  }

  _onCancelButtonPressed() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _song = widget.song;
    _nameEditingController = TextEditingController();
    _authorEditingController = TextEditingController();
    _musicLinkEditingController = TextEditingController();
    _sheetLinkEditingController = TextEditingController();
    _nameEditingController.text = _song.name;
    _authorEditingController.text = _song.author;
    _musicLinkEditingController.text = _song.musicLinkString;
    _sheetLinkEditingController.text = _song.sheetLinkString;

    _nameEditingController.addListener(() {
      _configureSaveButton();
    });
    _authorEditingController.addListener(() {
      _configureSaveButton();
    });
    _musicLinkEditingController.addListener(() {
      _configureSaveButton();
    });
    _sheetLinkEditingController.addListener(() {
      _configureSaveButton();
    });
  }

  _configureSaveButton() {
    setState(() {
      if (_nameEditingController.text != _song.name) {
        _isSaveButtonEnabled = true;
      } else if (_authorEditingController.text != _song.author) {
        _isSaveButtonEnabled = true;
      } else if (_musicLinkEditingController.text != _song.musicLinkString) {
        _isSaveButtonEnabled = true;
      } else if (_sheetLinkEditingController.text != _song.sheetLinkString) {
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
          Text(AppText.editSongTitle, style: AppTextStyle.cardTitle),
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
                editingController: _authorEditingController,
                title: AppText.author),
            Paddings.inlineSpacingBox,
            CustomTextField(
                editingController: _musicLinkEditingController,
                title: AppText.musicLink),
            Paddings.inlineSpacingBox,
            CustomTextField(
                editingController: _sheetLinkEditingController,
                title: AppText.sheet),
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
}
