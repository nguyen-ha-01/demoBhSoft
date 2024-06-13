import 'package:flutter/material.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "error",
        style: AppTextStyle.type24.copyWith(color: AppColor.alert),
      ),
    );
  }
}
