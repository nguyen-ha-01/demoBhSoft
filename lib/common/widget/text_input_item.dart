import 'package:flutter/material.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';

class TextInputItem extends StatelessWidget {
  final bool? isObscured;

  const TextInputItem({
    super.key,
    required this.hint,
    this.action,
    this.keyboard,
    this.validate,
    this.maxLine,
    required this.onChange,
    required this.controller,
    this.border,
    this.prefix,
    this.isObscured,
  });
  final TextEditingController controller;
  final TextInputAction? action;
  final TextInputType? keyboard;
  final String hint;
  final OutlineInputBorder? border;
  final String? Function(String?)? validate;
  final Widget? prefix;
  final Function(String) onChange;

  final int? maxLine;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: (v) {
          onChange(v);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            prefix: prefix,
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColor.border),
            ),
            border: InputBorder.none,
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8),
            //   borderSide: BorderSide(color: AppColor.border),
            // ),

            enabledBorder: border,
            hintStyle: AppTextStyle.hint),
        style: AppTextStyle.type24,
        obscureText: isObscured ?? false,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: action ?? TextInputAction.done,
        keyboardType: keyboard ?? TextInputType.text,
        validator: validate,
        maxLines: maxLine ?? 1,
      );
}

class TextInputItem2 extends StatelessWidget {
  const TextInputItem2(
      {super.key,
      required this.hint,
      this.action,
      this.keyboard,
      this.validate,
      this.maxLine,
      required this.onChange,
      required this.controller,
      this.prefix,
      required this.width});
  final double width;
  final TextEditingController controller;
  final TextInputAction? action;
  final TextInputType? keyboard;
  final String hint;

  final String? Function(String?)? validate;
  final Widget? prefix;
  final Function() onChange;

  final int? maxLine;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            prefix ??
                const SizedBox(
                  width: 0,
                  height: 0,
                ),
            SizedBox(
                width: width,
                child: IgnoreBaseline(
                  child: TextField(
                    onChanged: (v) {
                      onChange();
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: hint,
                        hintStyle: AppTextStyle.hint),
                    style: AppTextStyle.type24,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: action ?? TextInputAction.done,
                    keyboardType: keyboard ?? TextInputType.text,
                    maxLines: null,
                    minLines: null,
                  ),
                )),
          ],
        ),
      );
}
