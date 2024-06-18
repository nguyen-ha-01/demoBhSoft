import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';

class ItemBtn extends StatelessWidget {
  const ItemBtn({super.key, required this.iconR, required this.title, required this.onTab});
  final String iconR;
  final String title;
  final Function() onTab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: () async {
          onTab();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                iconR,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: AppTextStyle.type16,
              ),
              const Spacer(),
              SvgPicture.asset(
                Assets.icon.icPArrow,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              )
            ],
          ),
        ),
      ),
    );
  }
}
