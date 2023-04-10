import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_roster_models/music_roster_models.dart';
import 'package:music_team_admin/modules/dashboard/service_details_link_list.dart';
import 'package:music_team_admin/modules/dashboard/service_details_member_link.dart';
import 'package:music_team_admin/modules/dashboard/service_details_song_list.dart';

class ServiceDetailsDialog extends StatelessWidget {
  const ServiceDetailsDialog({super.key, required this.serviceModel});
  final ServiceModel serviceModel;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.8;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Row(
        children: [
          _renderServiceDetails(width),
          ServiceDetailsMemberList(width: width, serviceModel: serviceModel),
        ],
      ),
    );
  }

  _renderServiceDetails(double width) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.accent),
      width: width * 0.55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceModel.date.dateString(isYearDisplaying: true),
            style: AppTextStyle.getTextStyle(AppFont.h1, AppColors.label),
          ),
          const SizedBox(height: 24),
          ServiceDetailsSongList(serviceModel: serviceModel),
          const SizedBox(height: 24),
          ServiceDetailsLinkList(),
        ],
      ),
    );
  }
}
