import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:tiademo/common/widget/pages/icon_select_dialog.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/states/add_task_controller.dart';

class NewCategoryPage extends StatefulWidget {
  NewCategoryPage({super.key});

  @override
  State<NewCategoryPage> createState() => _NewCategoryPageState();
}

class _NewCategoryPageState extends State<NewCategoryPage> {
  // final List<int> colors = [0xff8687E7, 0xff8687E7, 0xff8687E7, 0xff696969];
  final nameController = TextEditingController();
  final AddTaskController controller = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (c) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  tr('category.h1'),
                  style: AppTextStyle.type24.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  tr('category.l1'),
                  style: AppTextStyle.type16,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextInputItem(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColor.border),
                  ),
                  hint: tr('category.l1'),
                  onChange: (String v) {
                    controller.newCategoryTitle.value = nameController.text;
                  },
                  controller: nameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(tr('category.l2'), style: AppTextStyle.type16),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => setIcon()),
                const SizedBox(
                  height: 8,
                ),
                Text(tr('category.l3'), style: AppTextStyle.type16),
                const SizedBox(
                  height: 8,
                ),
                colorPick(),
                const Spacer(),
                groupButton()
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget colorPick() {
    return Builder(builder: (c) {
      return SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) {
            return Obx(() => InkWell(
                  onTap: () {
                    controller.selectedColorPos.value = i;
                    print("color select at $i for pos ${controller.selectedColorPos.value}");
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(controller.colors[i]),
                        border: (controller.selectedColorPos.value == i)
                            ? Border.all(color: AppColor.white, width: 3)
                            : null),
                  ),
                ));
          },
          separatorBuilder: (c, p) => const SizedBox(
            width: 10,
          ),
          itemCount: controller.colors.length,
          shrinkWrap: true,
        ),
      );
    });
  }

  Widget groupButton() => Padding(
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
                        style: AppTextStyle.type16,
                      )))),
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    //todo: passing data
                    controller.createCategory();
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                      height: 48,
                      child: Center(
                          child: Text(
                        'category.b2'.tr(),
                        style: AppTextStyle.type16,
                      )))),
            )
          ],
        ),
      );

  Widget setIcon() {
    print("in setIcon ${controller.selectedIcon.value}------------------------");
    return controller.selectedIcon.value != -1
        ? Obx(() => InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () async {
                showDialog(context: context, builder: (c) => IconSelectDialog());
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    controller.iconSrcs[controller.selectedIcon.value],
                    placeholderBuilder: (context) => Container(),
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ))
        : InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () async {
              await showDialog(context: context, builder: (c) => IconSelectDialog());
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: AppColor.border, borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  tr('category.l5'),
                  style: AppTextStyle.type12,
                ),
              ),
            ));
  }
}
