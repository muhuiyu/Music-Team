import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';

class ServiceDetailsLinkList extends StatelessWidget {
  const ServiceDetailsLinkList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.link,
          color: AppColors.tertiaryLabel,
          size: WidgetSize.songLibraryIconSize,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LINKS', style: AppTextStyle.serviceDetailsSubtitle),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // TODO
                    },
                    child: Text('attachment')),
              ],
            ),
          ],
        )
      ],
    );
  }
}
