import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';

class ChangeAccountName extends StatefulWidget {
  const ChangeAccountName({super.key, required this.name});
  final String name;
  @override
  _ChangeAccountNameState createState() => _ChangeAccountNameState();
}

class _ChangeAccountNameState extends State<ChangeAccountName> {
  _ChangeAccountNameState();

  late final TextEditingController newName;
  @override
  void initState() {
    // TODO: implement initState
    newName = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('profile.7'),
              style: AppTextStyle.type20.copyWith(fontWeight: FontWeight.w700),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: AppColor.border,
                height: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputItem(hint: "", onChange: (v) {}, controller: newName),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                            height: 48,
                            child: Center(
                                child: Text(
                              'commons.l2'.tr(),
                              style: AppTextStyle.type20,
                            )))),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> data = {};
                          if (newName.text != widget.name && newName.text.isNotEmpty) {
                            data.addAll({'name': newName.text});
                          }
                          Navigator.pop(context, data);
                        },
                        child: SizedBox(
                            height: 48,
                            child: Center(
                                child: Text(
                              'detail.l10'.tr(),
                              style: AppTextStyle.type20,
                            )))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
