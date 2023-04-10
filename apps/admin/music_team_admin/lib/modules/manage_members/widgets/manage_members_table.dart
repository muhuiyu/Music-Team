import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_models/music_roster_models.dart';

class ManageMembersTable extends StatelessWidget {
  final List<UserModel> users;
  final Function(UserModel user) onEditButtonPressed;
  const ManageMembersTable({
    super.key,
    required this.users,
    required this.onEditButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    List<String> dataColumns = [
      AppText.name,
      AppText.roles,
      AppText.email,
      AppText.phone,
      AppText.actions,
    ];

    if (users.isEmpty) {
      return Container();
    }

    final double width = MediaQuery.of(context).size.width * 0.8;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width,
        child: DataTable(
          columnSpacing: 0,
          columns: dataColumns
              .map((e) => DataColumn(
                  label: Center(
                      child: Text(e,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.tableHeader))))
              .toList(),
          rows: users
              .map((user) => DataRow(
                    cells: [
                      _renderNameCell(user),
                      _renderRolesCell(user),
                      _renderEmailCell(user),
                      _renderPhoneCell(user),
                      _renderActionsCell(user),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }

  _renderNameCell(UserModel user) {
    return DataCell(
      Text(user.name, style: AppTextStyle.tableContent),
      onTap: () {
        // TODO: tap to copy
      },
    );
  }

  _renderRolesCell(UserModel user) {
    return DataCell(
      Row(
          children: user.roles
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      label: Row(
                        children: [
                          Icon(e.iconData),
                          Text(e.name),
                        ],
                      ),
                      backgroundColor: e.color.withAlpha(100),
                    ),
                  ))
              .toList()),
      onTap: () {
        // _showRolesMultiSelect(context);
      },
    );
  }

  _renderEmailCell(UserModel user) {
    return DataCell(
      Text(user.email ?? '', style: AppTextStyle.tableContent),
      onTap: () {
        // TODO: Tap to copy
      },
    );
  }

  _renderPhoneCell(UserModel user) {
    return DataCell(
      Text(user.phone ?? '', style: AppTextStyle.tableContent),
      onTap: () {
        // TODO: Tap to copy
      },
    );
  }

  _renderActionsCell(UserModel user) {
    return DataCell(Row(
      children: [
        IconButton(
          onPressed: () {
            onEditButtonPressed(user);
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
