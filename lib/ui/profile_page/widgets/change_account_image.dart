import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';

Widget changeAccountImage() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(8)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        tr('profile.7'),
        style: AppTextStyle.type20.copyWith(fontWeight: FontWeight.w700),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Divider(
          color: AppColor.border,
          height: 1,
        ),
      ),
      const SizedBox(
        height: 18,
      ),
      InkWell(
        onTap: () {},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('profile.18'.tr(), style: AppTextStyle.type16),
            )
          ],
        ),
      ),
      InkWell(
        onTap: () {},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text('profile.19'.tr(), style: AppTextStyle.type16),
            )
          ],
        ),
      ),
      InkWell(
        onTap: () {},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                'profile.20'.tr(),
                style: AppTextStyle.type16,
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      )
    ]),
  );
}
