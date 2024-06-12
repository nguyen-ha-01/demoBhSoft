import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';

class Intro_1_page extends StatelessWidget {
  const Intro_1_page({super.key, required this.back, required this.next});
  final Function() back;
  final Function() next;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 52,
          ),
          SvgPicture.asset(
            Assets.icon.icIntro1,
            width: 271,
            height: 296,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 22,
          ),
          Text(
            tr('login.l1'),
            style: AppTextStyle.type24.copyWith(fontSize: 32, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: Text(
              tr('login.l2'),
              style: AppTextStyle.type16,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {
                      back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        tr('login.b1'),
                        style: AppTextStyle.type20,
                      ),
                    ),
                  )),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      next();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(tr('login.b2'), style: AppTextStyle.type20.copyWith(color: AppColor.white)),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
