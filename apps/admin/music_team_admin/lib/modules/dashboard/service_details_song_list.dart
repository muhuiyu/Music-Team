import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/models/service/service_model.dart';
import 'package:music_team_admin/models/service/song_record.dart';

class ServiceDetailsSongList extends StatelessWidget {
  const ServiceDetailsSongList({
    super.key,
    required this.serviceModel,
  });
  final ServiceModel serviceModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.music_note,
          color: AppColors.tertiaryLabel,
          size: WidgetSize.songLibraryIconSize,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SONGS', style: AppTextStyle.serviceDetailsSubtitle),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: AppColors.lightGrey, width: 1))),
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    serviceModel.songs.map((e) => _renderSongTile(e)).toList(),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _renderSongTile(SongRecord songRecord) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              songRecord.songName,
              style: AppTextStyle.getTextStyle(AppFont.body, AppColors.label,
                  weight: TextStyleWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  // TODO:
                },
                icon: Icon(Icons.square,
                    size: WidgetSize.serviceDetailsIconButtonSize)),
            IconButton(
                onPressed: () {
                  // TODO:
                },
                icon: Icon(Icons.square,
                    size: WidgetSize.serviceDetailsIconButtonSize)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          songRecord.note,
          style: AppTextStyle.getTextStyle(
              AppFont.small, AppColors.secondaryLabel),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
