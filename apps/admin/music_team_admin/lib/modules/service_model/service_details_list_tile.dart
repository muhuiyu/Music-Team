import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/modules/common/screens/webview_screen.dart';
import 'package:music_team_admin/widgets/custom_button.dart';

class ServiceDetailsListTile extends StatelessWidget {
  final IconData? iconData;
  final String? imageName;
  final double? imageSize;
  final String title;
  final String content;
  final Color tintColor;
  final String? attachmentTitle;
  final String? attachmentUrlString;
  final bool isSeparatorHidden;
  final bool isDisclosureIndicatorHidden;
  Function()? onTap;

  ServiceDetailsListTile({
    super.key,
    this.iconData,
    this.imageName,
    this.imageSize,
    required this.title,
    this.content = '',
    this.tintColor = AppColors.primary,
    this.attachmentTitle,
    this.attachmentUrlString,
    this.isSeparatorHidden = true,
    this.isDisclosureIndicatorHidden = true,
    this.onTap,
  });

  _onAttachmentButtonPressed() {
    if (attachmentUrlString == null) {
      return;
    }
    // TODO:
    // Get.to(WebViewScreen(urlString: attachmentUrlString!));
  }

  _onDisclosureIndicatorPressed() {
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    BoxBorder? border = isSeparatorHidden
        ? null
        : Border(bottom: BorderSide(color: AppColors.accent, width: 1));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: AppColors.white, border: border),
      child: ListTile(
        leading: _renderLeadingView(),
        title: _renderContent(),
        contentPadding: const EdgeInsets.only(left: 12),
        trailing: isDisclosureIndicatorHidden
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
                onPressed: () {
                  _onDisclosureIndicatorPressed();
                },
              ),
        onTap: onTap,
      ),
    );
  }

  Widget _renderLeadingView() {
    if (imageName != null) {
      // TODO: change to different way to render image
      return CircleAvatar(
        radius: imageSize,
        child: Image.asset(imageName!),
      );
    } else if (iconData != null) {
      return Icon(
        iconData,
        color: tintColor,
      );
    } else {
      return Container();
    }
  }

  Widget _renderContent() {
    List<Widget> widgets = [];
    widgets.add(Text(
      title,
      style: AppTextStyle.cardGridTitle,
    ));
    if (content.isNotEmpty) {
      widgets.addAll([
        const SizedBox(height: 4),
        Text(
          content,
          style: AppTextStyle.cardGridSubtitle,
        ),
      ]);
    }
    if (attachmentTitle != null) {
      widgets.addAll([
        Paddings.cardGridInlineSpacingBox,
        SizedBox(
          height: 50,
          width: 200,
          child: CustomTextButton(
            onPressed: () {
              _onAttachmentButtonPressed();
            },
            type: CustomButtonType.secondary,
            text: attachmentTitle!,
          ),
        ),
      ]);
    }

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );

    return column;
  }
}
