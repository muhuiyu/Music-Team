import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/models/service/service_model.dart';
import 'package:music_team_admin/models/user/user_model.dart';
import 'package:music_team_admin/models/user/user_role.dart';
import 'package:music_team_admin/modules/planner/planner_multi_select.dart';
import 'package:music_team_admin/modules/planner/planner_role_block.dart';

class PlannerRosterTable extends StatelessWidget {
  final List<ServiceModel> services;
  final Function(
          ServiceModel serviceModel, UserRole role, List<UserModel> users)
      onSaveButtonPressed;
  final Map<String, UserModel> userMap;

  const PlannerRosterTable({
    super.key,
    required this.services,
    required this.onSaveButtonPressed,
    required this.userMap,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return Container();
    } else {
      return Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 10,
            dataRowMinHeight: 200,
            dataRowMaxHeight: 200,
            columns: services
                .map((service) => DataColumn(
                        label: SizedBox(
                      width: WidgetSize.plannerBlockWidth,
                      child: Center(
                          child: Text(service.date.dateString(),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.tableHeader)),
                    )))
                .toList(),
            rows: [
              DataRow(
                  cells: services
                      .map((service) =>
                          _renderRoleBlock(context, service, UserRole.lead))
                      .toList()),
              DataRow(
                  cells: services
                      .map((service) =>
                          _renderRoleBlock(context, service, UserRole.vocal))
                      .toList()),
              DataRow(
                  cells: services
                      .map((service) =>
                          _renderRoleBlock(context, service, UserRole.piano))
                      .toList()),
              DataRow(
                  cells: services
                      .map((service) =>
                          _renderRoleBlock(context, service, UserRole.drums))
                      .toList()),
              DataRow(
                  cells: services
                      .map((service) =>
                          _renderRoleBlock(context, service, UserRole.guitar))
                      .toList()),
              DataRow(
                  cells: services
                      .map((service) =>
                          _renderRoleBlock(context, service, UserRole.bass))
                      .toList()),
              DataRow(
                  cells: services
                      .map((service) =>
                          _renderRoleBlock(context, service, UserRole.cajon))
                      .toList()),
            ],
          ),
        ),
      );
    }
  }

  _showSelectUserDialog(
    BuildContext context,
    ServiceModel serviceModel,
    UserRole role,
    List<UserModel> selectedUsers,
  ) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
            title: 'Select ${role.name} on ${serviceModel.date.dateString()}',
            selectedItem: selectedUsers.map((e) => e.name).toList(),
            items: userMap.values
                .where((user) => user.roles.contains(role))
                .map<String>((e) => e.name)
                .toList());
      },
    );

    if (results == null) {
      return;
    }

    final updatedSelectedUsers = results.map<UserModel>((name) {
      return userMap.values.firstWhere((element) => element.name == name);
    }).fold(List<UserModel>.empty(growable: true), (previousValue, element) {
      if (element != null) {
        previousValue.add(element);
      }
      return previousValue;
    }).toList();

    if (updatedSelectedUsers != selectedUsers) {
      onSaveButtonPressed(serviceModel, role, updatedSelectedUsers);
    }
  }

  DataCell _renderRoleBlock(
      BuildContext context, ServiceModel serviceModel, UserRole role) {
    final selectedUsers = serviceModel.duty[role] ?? [];

    return DataCell(
        PlannerRoleBlock(
          date: serviceModel.date,
          role: role,
          selectedUsers: selectedUsers,
          userMap: userMap,
        ), onTap: () {
      _showSelectUserDialog(context, serviceModel, role, selectedUsers);
    });
  }
}
