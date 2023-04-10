import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_api/music_roster_api.dart';
import 'package:music_team_admin/main.dart';
import 'package:music_team_admin/models/common/screen_name.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:music_team_admin/modules/common/widgets/custom_page.dart';
import 'package:music_team_admin/modules/common/widgets/search_bar.dart';
import 'package:music_team_admin/modules/manage_members/widgets/edit_member_dialog.dart';
import 'package:music_team_admin/modules/manage_members/widgets/manage_members_table.dart';
import 'package:music_team_admin/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ManageMembersScreen extends StatefulWidget {
  const ManageMembersScreen({super.key});

  @override
  State<ManageMembersScreen> createState() => _ManageMembersScreenState();
}

class _ManageMembersScreenState extends State<ManageMembersScreen>
    with RouteAware {
  late TextEditingController _editingController;
  late Map<String, UserModel> _users = {};
  late List<UserModel> _displayedUsers = [];
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
    _users.clear();
    _displayedUsers.clear();
    super.dispose();
  }

  int getTotalNumberOfPages(List<UserModel> users) {
    return (users.length / DataProvider.numberOfEntriesPerPage).ceil();
  }

  @override
  void didPopNext() {
    _fetchData();
    super.didPopNext();
  }

  _fetchData() async {
    _dataProvider.fetchAllUsers().then((value) {
      setState(() {
        _users = value;
        _displayedUsers = _users.values.toList();
      });
    }).onError((error, stackTrace) {
      AppMessage.errorMessage(error.toString());
    });
  }

  _filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedUsers = _users.values.toList();
      } else {
        _displayedUsers = _users.values
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  _onEditButtonPressed(UserModel user) async {
    final UserModel updatedUser = await showDialog(
      context: context,
      builder: (context) {
        return EditMemberDialog(user: user);
      },
    );
    if (updatedUser != null) {
      _dataProvider.updateUser(updatedUser).onError(
          (error, stackTrace) => AppMessage.errorMessage(error.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      currentScreen: ScreenName.manageMembers,
      widgets: [
        _renderHeader(),
        Paddings.inlineSpacingBox,
        _renderTable(),
      ],
    );
  }

  _showAddMemberDialog() async {
    final UserModel newUser = await showDialog(
      context: context,
      builder: (context) {
        return EditMemberDialog(
          user: UserModel.emptyUser,
        );
      },
    );
    if (newUser != null) {
      _dataProvider.addUser(newUser).onError(
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
            text: AppText.addMemberButtonText,
            onPressed: () {
              _showAddMemberDialog();
            },
            type: CustomButtonType.primary),
      ],
    );
  }

  _renderTable() {
    if (_users.isEmpty) {
      return Container();
    }
    return ManageMembersTable(
      users: _displayedUsers,
      onEditButtonPressed: _onEditButtonPressed,
    );
  }
}
