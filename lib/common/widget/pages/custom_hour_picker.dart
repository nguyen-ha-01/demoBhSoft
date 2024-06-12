import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tiademo/common/widget/pm_am.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';

class HourPicker extends StatefulWidget {
  const HourPicker(
      {super.key,
      this.background,
      required this.handleCancel,
      required this.handleOk,
      this.cancelLabel,
      this.submitLabel});
  final Color? background;
  final Function(int, int, String) handleOk;
  final Function() handleCancel;
  final String? cancelLabel, submitLabel;
  @override
  _HourPickerState createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  _HourPickerState();
  int _hour = 1;
  int _minute = 0;
  String m = 'Am';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
        decoration: BoxDecoration(
            color: widget.background ?? AppColor.dialog_background, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('picker.b2'),
              style: AppTextStyle.type20.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(height: 3, color: AppColor.border),
            const SizedBox(
              height: 21,
            ),
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(color: widget.background ?? AppColor.dialog_background),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(color: AppColor.flagDismiss, borderRadius: BorderRadius.circular(10)),
                    child: NumberPicker(
                      minValue: 1,
                      maxValue: 12,
                      itemWidth: 32,
                      itemHeight: 32,
                      value: _hour,
                      onChanged: (int value) {
                        setState(() {
                          _hour = value;
                        });
                      },
                      selectedTextStyle: AppTextStyle.type24.copyWith(fontWeight: FontWeight.w700),
                      textStyle: AppTextStyle.type16
                          .copyWith(color: const Color(0xffffffff).withOpacity(0.1), fontWeight: FontWeight.w700),
                      infiniteLoop: true,
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  SvgPicture.asset(
                    Assets.icon.icPickerDotdot,
                    width: 6,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(color: AppColor.flagDismiss, borderRadius: BorderRadius.circular(10)),
                    child: NumberPicker(
                      minValue: 0,
                      maxValue: 60,
                      itemWidth: 32,
                      itemHeight: 32,
                      value: _minute,
                      onChanged: (int value) {
                        setState(() {
                          _minute = value;
                        });
                      },
                      selectedTextStyle: AppTextStyle.type24.copyWith(fontWeight: FontWeight.w700),
                      textStyle: AppTextStyle.type16
                          .copyWith(color: const Color(0xffffffff).withOpacity(0.1), fontWeight: FontWeight.w700),
                      infiniteLoop: true,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(color: AppColor.flagDismiss, borderRadius: BorderRadius.circular(10)),
                    child: PmAmPicker(
                      value: m,
                      width: 84,
                      height: 84,
                      onChanged: (v) {
                        setState(() {
                          m = v;
                        });
                      },
                      p1: 'Am',
                      p2: 'Pm',
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      widget.handleCancel();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        //cancel
                        widget.cancelLabel ?? "Cancel",
                        style: AppTextStyle.type20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    widget.handleOk(_hour, _minute, m);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                        //ok
                        widget.submitLabel ?? "Save",
                        style: AppTextStyle.type20.copyWith(color: AppColor.white)),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
