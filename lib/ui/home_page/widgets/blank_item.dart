import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';

class BlankItem extends StatelessWidget {
  const BlankItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.icon.icHome1),
        Text(
          'home.lb1'.tr(),
          style: AppTextStyle.type20,
        ),
        Text(
          "home.lb2".tr(),
          style: AppTextStyle.type16,
        )
      ],
    );
  }
}
