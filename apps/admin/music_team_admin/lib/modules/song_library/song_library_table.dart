import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_models/music_roster_models.dart';

class SongLibraryTable extends StatelessWidget {
  final List<Song> songs;
  final Function(Song song) onEditButtonPressed;
  const SongLibraryTable({
    super.key,
    required this.songs,
    required this.onEditButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return Container();
    }

    final double width = MediaQuery.of(context).size.width * 0.8;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width,
        child: DataTable(
          columnSpacing: 0,
          columns: _renderDataColumns(width),
          rows: songs
              .map((song) => DataRow(
                    cells: [
                      _renderNameCell(song),
                      _renderAuthorCell(song),
                      _renderMusicLinkCell(song),
                      _renderSheetCell(song),
                      _renderActionsCell(song),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }

  List<DataColumn> _renderDataColumns(double width) {
    return [
      DataColumn(
        label: SizedBox(
          width: width * 0.4,
          child: Text(AppText.name, style: AppTextStyle.tableHeader),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: width * 0.3,
          child: Text(AppText.author, style: AppTextStyle.tableHeader),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: width * 0.1,
          child: Text(AppText.musicLink, style: AppTextStyle.tableHeader),
        ),
      ),
      DataColumn(
        label: SizedBox(
            width: width * 0.1,
            child: Text(AppText.sheet, style: AppTextStyle.tableHeader)),
      ),
      DataColumn(
        label: SizedBox(
            width: width * 0.1,
            child: Text(AppText.actions, style: AppTextStyle.tableHeader)),
      ),
    ];
  }

  _renderNameCell(Song song) {
    return DataCell(
      Text(song.name, style: AppTextStyle.tableContent),
      onTap: () {
        // TODO: tap to copy
      },
    );
  }

  _renderAuthorCell(Song song) {
    return DataCell(
      Text(song.author, style: AppTextStyle.tableContent),
      onTap: () {
        // TODO: tap to copy
      },
    );
  }

  _renderMusicLinkCell(Song song) {
    if (song.musicLinkString.isEmpty) {
      return DataCell(Container());
    }
    return DataCell(
      SvgPicture.asset(
        AppImage.youtubeLogo,
        semanticsLabel: 'YouTube logo',
        width: WidgetSize.songLibraryIconSize,
      ),
      onTap: () => _launchURL(song.musicLinkString),
    );
  }

  _launchURL(url) {
    html.window.open(url, '');
  }

  _renderSheetCell(Song song) {
    if (song.sheetLinkString.isEmpty) {
      return DataCell(Container());
    }
    return DataCell(
      Icon(
        Icons.note,
        size: WidgetSize.songLibraryIconSize,
      ),
      onTap: () => _launchURL(song.sheetLinkString),
    );
  }

  _renderActionsCell(Song song) {
    return DataCell(Row(
      children: [
        IconButton(
          onPressed: () {
            onEditButtonPressed(song);
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () {
            // TODO:
          },
          icon: Icon(Icons.more),
        )
      ],
    ));
  }
}
