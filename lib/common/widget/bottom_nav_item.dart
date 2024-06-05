import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_textstyle.dart';

class BottomNavItem extends StatelessWidget {
  final Function() onTap;
  final String icon;
  final String label;
  final String iconSelected;
  final bool isSelected;
  const BottomNavItem(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.label,
      required this.iconSelected,
      required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              (isSelected) ? iconSelected : icon,
              width: 24,
              height: 24,
            ),
            Text(
              label,
              style: AppTextStyle.type12,
            )
          ],
        ),
      ),
    );
  }
}
