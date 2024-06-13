import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/category.dart';

class CategorySelectorItem extends StatelessWidget {
  final Category category;
  final String? selectedCategoryId;
  final Function(Category) onSelected;

  CategorySelectorItem({super.key, required this.category, required this.onSelected, this.selectedCategoryId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onSelected(category),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: Color(category.colorId), borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  category.iconId,
                  width: 32,
                  height: 32,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Flexible(
            child: Text(
              category.name,
              style: AppTextStyle.type14,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

class CategoryCreateBtn extends StatelessWidget {
  final Function() onSelected;

  CategoryCreateBtn({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print("click");
              onSelected();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: AppColor.green, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Assets.icon.icCommonAdd,
                  width: 32,
                  height: 32,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(
            tr('commons.l6'),
            style: AppTextStyle.type14,
          )
        ],
      ),
    );
  }
}
