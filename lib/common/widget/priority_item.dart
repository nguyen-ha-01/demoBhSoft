import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';

class PriorityItem extends StatelessWidget {
  final String value;
  const PriorityItem({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      decoration: BoxDecoration(
          color: AppColor.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColor.primary)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.icon.icHomeSheetFlag,
            height: 14,
            width: 14,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            value,
            style: AppTextStyle.type12_cate,
          )
        ],
      ),
    );
  }
}
