import 'package:flutter/material.dart';
import 'package:tiademo/core/app_color.dart';

class AppTextStyle {
  static TextStyle type16 = TextStyle(color: AppColor.main_content, fontSize: 18, fontWeight: FontWeight.w400);

  static TextStyle type20 = TextStyle(color: AppColor.main_content, fontSize: 22, fontWeight: FontWeight.w400);
  static TextStyle type14_low = TextStyle(color: AppColor.task_low, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle type14 = TextStyle(
    color: AppColor.main_content,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle type24 = TextStyle(color: AppColor.main_content, fontSize: 24, fontWeight: FontWeight.w500);
  static TextStyle type12 = const TextStyle(color: AppColor.main_content, fontSize: 20, fontWeight: FontWeight.w400);
  static TextStyle type12_cate = const TextStyle(
    color: AppColor.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle hint =
      const TextStyle(color: Color(0xffAFAFAF), fontSize: 14, fontWeight: FontWeight.w400, textBaseline: null);
}
