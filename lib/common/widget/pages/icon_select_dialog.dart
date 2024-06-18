import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/states/add_task_controller.dart';

class IconSelectDialog extends StatelessWidget {
  IconSelectDialog({super.key});

  final AddTaskController controller = Get.find();

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
              tr('category.l6'),
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
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Số cột
                  crossAxisSpacing: 4.0, // Khoảng cách giữa các cột
                  mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                ),
                itemCount: controller.iconSrcs.length,
                itemBuilder: (context, index) {
                  return Obx(() => IconSelectItem(
                        src: controller.iconSrcs[index],
                        isSelect: controller.selectedIconPos.value == index,
                        onTab: () {
                          controller.selectedIconPos.value = index;
                          print("icon select at $index for icon ${controller.selectedIconPos.value}");
                        },
                      ));
                },
              ),
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
                          controller.setIconOnCreateCategory();
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                            height: 48,
                            child: Center(
                                child: Text(
                              'commons.l3'.tr(),
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

class IconSelectItem extends StatelessWidget {
  const IconSelectItem({super.key, required this.src, required this.isSelect, required this.onTab});

  final String src;
  final bool isSelect;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        onTab();
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            color: AppColor.btnColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isSelect ? AppColor.primary : AppColor.border)),
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          src,
          width: 48,
          height: 48,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
