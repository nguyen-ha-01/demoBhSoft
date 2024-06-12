import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';

class PriorityButtonItem extends StatelessWidget {
  final Function() onTap;
  final bool isSelected;
  final String value;

  const PriorityButtonItem({super.key, required this.onTap, required this.isSelected, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        print('tap$value');
      },
      child: Container(
        width: 74,
        height: 74,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
            color: (isSelected) ? AppColor.primary : AppColor.flagDismiss, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.icon.icHomeSheetFlag,
              width: 30,
              height: 30,
            ),
            // const SizedBox(
            //   height: 8,
            // ),
            Text(
              value,
              style: AppTextStyle.type20,
            )
          ],
        ),
      ),
    );
  }
}
