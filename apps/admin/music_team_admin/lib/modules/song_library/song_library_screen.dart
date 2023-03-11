import 'package:flutter/material.dart';
import 'package:music_team_admin/api/providers/data_provider.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/helpers/app_message.dart';
import 'package:music_team_admin/main.dart';
import 'package:music_team_admin/models/common/screen_name.dart';
import 'package:music_team_admin/models/service/song.dart';
import 'package:music_team_admin/models/user/user_model.dart';
import 'package:music_team_admin/modules/common/widgets/custom_page.dart';
import 'package:music_team_admin/modules/common/widgets/search_bar.dart';
import 'package:music_team_admin/modules/manage_members/edit_member_dialog.dart';
import 'package:music_team_admin/modules/song_library/edit_song_dialog.dart';
import 'package:music_team_admin/modules/song_library/song_library_table.dart';
import 'package:music_team_admin/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SongLibraryScreen extends StatefulWidget {
  const SongLibraryScreen({super.key});

  @override
  State<SongLibraryScreen> createState() => _SongLibraryScreenState();
}

class _SongLibraryScreenState extends State<SongLibraryScreen> with RouteAware {
  late TextEditingController _editingController;
  late Map<String, Song> _songs = {};
  late List<Song> _displayedSongs = [];
  late DataProvider _dataProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    _editingController = TextEditingController();
    _dataProvider = Provider.of<DataProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _fetchData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _songs.clear();
    _displayedSongs.clear();
    super.dispose();
  }

  @override
  void didPopNext() {
    _fetchData();
    super.didPopNext();
  }

  int getTotalNumberOfPages(List<Song> songs) {
    return (songs.length / DataProvider.numberOfEntriesPerPage).ceil();
  }

  _fetchData() async {
    _dataProvider.fetchAllSongs().then((value) {
      setState(() {
        _songs = value;
        _displayedSongs = _songs.values.toList();
      });
    }).onError((error, stackTrace) {
      AppMessage.errorMessage(error.toString());
    });
  }

  _filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedSongs = _songs.values.toList();
      } else {
        _displayedSongs = _songs.values
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  _onEditButtonPressed(Song song) async {
    final Song updatedSong = await showDialog(
      context: context,
      builder: (context) {
        return EditSongDialog(song: song);
      },
    );
    if (updatedSong != null) {
      _dataProvider.updateSong(updatedSong).onError(
          (error, stackTrace) => AppMessage.errorMessage(error.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      currentScreen: ScreenName.songLibrary,
      widgets: [
        _renderHeader(),
        Paddings.inlineSpacingBox,
        _renderTable(),
      ],
    );
  }

  _showAddSongDialog() async {
    final Song newSong = await showDialog(
      context: context,
      builder: (context) {
        return EditSongDialog(
          song: Song.emptySong,
        );
      },
    );
    if (newSong != null) {
      _dataProvider.addSong(newSong).onError(
          (error, stackTrace) => AppMessage.errorMessage(error.toString()));
    }
  }

  _renderHeader() {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: SearchBar(
              editingController: _editingController,
              onChanged: _filterSearchResults),
        ),
        const Spacer(),
        CustomTextButton(
            text: AppText.addSongButtonText,
            onPressed: () {
              _showAddSongDialog();
            },
            type: CustomButtonType.primary),
      ],
    );
  }

  _renderTable() {
    if (_songs.isEmpty) {
      return Container();
    }
    return SongLibraryTable(
      songs: _displayedSongs,
      onEditButtonPressed: _onEditButtonPressed,
    );
  }
}
