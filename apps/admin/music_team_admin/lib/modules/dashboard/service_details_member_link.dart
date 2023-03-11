import 'package:flutter/material.dart';
import 'package:music_team_admin/constants/constants.dart';
import 'package:music_team_admin/models/service/service_model.dart';

class ServiceDetailsMemberList extends StatelessWidget {
  const ServiceDetailsMemberList({
    super.key,
    required this.serviceModel,
    required this.width,
  });

  final ServiceModel serviceModel;
  final double width;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Text('TEAM', style: AppTextStyle.serviceDetailsSubtitle),
      const SizedBox(height: 16),
    ];
    widgets.addAll(serviceModel.duty.entries.map((e) => Row(
          children: [
            SizedBox(
                width: width * 0.1,
                child: Text(
                  e.key.name,
                  style: AppTextStyle.getTextStyle(
                      AppFont.body, AppColors.secondaryLabel),
                )),
            Column(
                children: e.value
                    .map((e) => Text(e.name,
                        style: AppTextStyle.getTextStyle(
                            AppFont.body, AppColors.label)))
                    .toList()),
          ],
        )));
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.white),
      width: width * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}
