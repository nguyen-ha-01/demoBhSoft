import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/states/edit_task_controller.dart';

class EditTaskTitle extends StatefulWidget {
  const EditTaskTitle({super.key, required this.title, required this.description});
  final String title;
  final String? description;

  @override
  State<EditTaskTitle> createState() => _EditTaskTitleState();
}

class _EditTaskTitleState extends State<EditTaskTitle> {
  late final TextEditingController _title, _description;
  @override
  void initState() {
    _title = TextEditingController(text: widget.title);
    _description = TextEditingController(text: widget.description ?? "");
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
              tr('detail.l8'),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: Column(
                children: [
                  TextInputItem(
                    controller: _title,
                    hint: '',
                    onChange: (String _) {},
                    action: TextInputAction.next,
                  ),
                  TextInputItem(
                    controller: _description,
                    hint: '',
                    onChange: (String _) {},
                    action: TextInputAction.done,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: SizedBox(
                            height: 48,
                            child: Center(
                                child: Text(
                              'detail.l9'.tr(),
                              style: AppTextStyle.type20,
                            )))),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          //todo:return new data
                          Map<String, dynamic> data = {};
                          if (_title.text != widget.title) {
                            EditTaskController c = Get.find();
                            c.editTaskTitle(_title.text);

                            data.addAll({'title': _title.text});
                          }
                          if (_description.text != widget.description) {
                            data.addAll({'description': _description.text});
                          }
                          if (kDebugMode) {
                            print(
                                "edit_task_dialog return ${data.toString()}-------------------------------------------");
                          }
                          Get.back<Map<String, dynamic>>(result: data);
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

  @override
  void dispose() {
    // TODO: implement dispose
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}
