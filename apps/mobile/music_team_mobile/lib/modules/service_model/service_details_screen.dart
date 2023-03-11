import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_team_mobile/api/mock_data.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_team_mobile/models/common/screen_name.dart';
import 'package:music_team_mobile/models/service/service_model.dart';
import 'package:music_team_mobile/models/service/song_record.dart';
import 'package:music_team_mobile/modules/common/widgets/custom_app_bar.dart';
import 'package:music_team_mobile/modules/service_model/service_details_list_tile.dart';
import 'package:music_team_mobile/router/router.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  // final ServiceModel service = Get.arguments[RoutesArgumentKey.serviceModel];
  final ServiceModel _service = serviceModelTestEntry;

  _onSongTap(SongRecord song) {
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(currentScreen: ScreenName.serviceDetails),
      body: SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Paddings.cardGridInlineSpacingBox,
                  _renderHeader(),
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: AppColors.grey,
                    tabs: const [
                      Tab(text: AppText.songs),
                      Tab(text: AppText.members),
                      Tab(text: AppText.note),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _renderSongsPage(),
                        _renderMembersPage(),
                        _renderNotePage(),
                      ],
                    ),
                  )
                ])),
      ),
    );
  }

  Widget _renderHeader() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          // TODO:
          // Paddings.cardGridInlineSpacingBox,
          ServiceDetailsListTile(
              imageName: 'assets/user_test.jpg', title: 'Led by Timmy Chen'),
          ServiceDetailsListTile(
            iconData: Icons.access_time,
            title: 'Feb 23, 10:15am Service',
            content: 'Rehearse on Feb 22, 11:30am',
          ),
          // Paddings.cardGridInlineSpacingBox,
          // _tabPages[_currentIndex],
        ],
      ),
    );
  }

  Widget _renderNotePage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Text(
        'some notes here if there is any',
        style: AppTextStyle.cardGridTitle,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _renderSongsPage() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        children: _service.songs
            .map((song) => ServiceDetailsListTile(
                  iconData: Icons.music_note,
                  title: song.songName,
                  content: song.note,
                  isDisclosureIndicatorHidden: false,
                  onTap: () {
                    _onSongTap(song);
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _renderMembersPage() {
    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          ServiceDetailsListTile(
            title: 'Member 1',
            content: 'Bass',
            imageName: 'assets/user_test.jpg',
          ),
          ServiceDetailsListTile(
            title: 'Member 2',
            content: 'Piano, vocal',
            imageName: 'assets/user_test.jpg',
          ),
        ],
      ),
    );
  }
}
