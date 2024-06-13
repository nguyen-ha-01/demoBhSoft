import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';

class DeleteTask extends StatelessWidget {
  const DeleteTask({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 9, right: 9, bottom: 5),
        decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('detail.l11'),
              style: AppTextStyle.type20.copyWith(fontWeight: FontWeight.w700),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: AppColor.border,
                height: 1,
              ),
            ),
            Text(
              tr('detail.l12'),
              style: AppTextStyle.type16,
            ),
            Text(
              tr('detail.l13') + title,
              style: AppTextStyle.type16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: SizedBox(
                          height: 48,
                          child: Center(
                              child: Text(
                            'detail.l9'.tr(),
                            style: AppTextStyle.type20,
                          )))),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        //return true to delete
                        Get.back(result: true);
                      },
                      child: SizedBox(
                          height: 48,
                          child: Center(
                              child: Text(
                            'detail.l10'.tr(),
                            style: AppTextStyle.type20,
                          )))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
