import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/routes/named_route.dart';

class Intro_4_page extends StatelessWidget {
  const Intro_4_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 95,
          ),
          Text(
            tr('login.l7'),
            style: AppTextStyle.type24.copyWith(fontSize: 32, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 26,
          ),
          Text(
            tr('login.l8'),
            style: AppTextStyle.type24.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(NamedRoutes.login_page);
              },
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColor.primary, borderRadius: BorderRadius.circular(8)),
                child: Center(child: Text(tr('login.b4'), style: AppTextStyle.type20.copyWith(color: AppColor.white))),
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(NamedRoutes.signup_page);
              },
              child: Container(
                height: 48,
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: AppColor.primary), borderRadius: BorderRadius.circular(8)),
                child: Center(child: Text(tr('login.b5'), style: AppTextStyle.type20.copyWith(color: AppColor.white))),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
