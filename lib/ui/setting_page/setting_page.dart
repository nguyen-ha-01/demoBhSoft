import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/ui/profile_page/widgets/item_btn.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          Assets.icon.icRegisterArrBack,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      tr('setting.1'),
                      style: AppTextStyle.type24,
                    ),
                  )),
                  const SizedBox(
                    width: 32,
                    height: 32,
                  )
                ],
              ),
            ),
            ItemBtn(iconR: Assets.icon.icSetColor, title: tr('setting.2'), onTab: () async {}),
            const SizedBox(
              height: 28,
            ),
            ItemBtn(iconR: Assets.icon.icSetTypo, title: tr('setting.3'), onTab: () async {}),
            const SizedBox(
              height: 28,
            ),
            ItemBtn(iconR: Assets.icon.icSetLang, title: tr('setting.4'), onTab: () async {}),
            const SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}
