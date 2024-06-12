import 'package:flutter/material.dart';
import 'package:tiademo/core/app_color.dart';

class OutlineBtn extends StatelessWidget {
  const OutlineBtn({super.key, this.child, required this.onTap, this.color, this.height, this.width});

  final Widget? child;
  final Function() onTap;

  final Color? color;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
          height: height ?? 48,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), border: Border.all(color: color ?? AppColor.primary)),
          child: child ?? Text("button")),
    );
  }
}
