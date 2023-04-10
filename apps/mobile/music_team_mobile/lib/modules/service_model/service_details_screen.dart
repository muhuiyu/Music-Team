import 'package:flutter/material.dart';
import 'package:music_team_mobile/mock_data.dart';
import 'package:music_team_mobile/constants/constants.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:music_team_mobile/modules/service_model/service_details_list_tile.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen>
    with SingleTickerProviderStateMixin {
  // final ServiceModel service = Get.arguments[RoutesArgumentKey.serviceModel];
  final ServiceModel _service = serviceModelTestEntry;
  final List<String> _tabNames = ['song', 'members', 'note'];
  late List<Widget> _tabs = [];
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: _tabNames.length, vsync: this);
    _tabs = [
      _renderSongsPage(),
      _renderMembersPage(),
      _renderNotePage(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  _onSongTap(SongRecord song) {
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    TabBar _tabbar = TabBar(
      isScrollable: true,
      controller: tabController,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: AppColors.grey,
      indicatorWeight: 3.0,
      tabs: _tabNames
          .map((e) => Text(e.toUpperCase(), style: AppTextStyle.tabbarItem))
          .toList(),
      onTap: (index) {
        VerticalScrollableTabBarStatus.setIndex(index);
      },
    );

    return Scaffold(
      body: SafeArea(
        child: VerticalScrollableTabView(
          tabController: tabController,
          listItemData: _tabNames,
          verticalScrollPosition: VerticalScrollPosition.begin,
          eachItemChild: (object, index) => _tabs[index] ?? Container(),
          slivers: [
            SliverAppBar(
              pinned: true,
              collapsedHeight: 150,
              expandedHeight: 150,
              flexibleSpace: _renderHeader(),
              bottom: PreferredSize(
                preferredSize: _tabbar.preferredSize,
                child: Material(
                  color: AppColors.accent,
                  child: _tabbar,
                ),
              ),
            ),
          ],
        ),
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
