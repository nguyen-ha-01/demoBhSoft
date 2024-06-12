import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_textstyle.dart';

class CategoryItem extends StatelessWidget {
  final int color;
  final String category;
  final String asset;

  const CategoryItem({super.key, required this.category, required this.color, required this.asset});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset,
            height: 14,
            width: 14,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            category,
            style: AppTextStyle.type12_cate,
          )
        ],
      ),
    );
  }
}
