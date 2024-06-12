import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiademo/common/widget/flag_priority_button_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/models/priority.dart';

Widget prioritySelectPage(BuildContext ctx, Function(int e) onSelect, int selectedPriority, Function() onSave) {
  return Dialog(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr('commons.l1'),
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
              itemCount: MePriority.lists.length,
              itemBuilder: (context, index) {
                return PriorityButtonItem(
                  onTap: () {
                    onSelect(MePriority.lists[index]);
                  },
                  isSelected: selectedPriority == MePriority.lists[index],
                  value: MePriority.lists[index].toString(),
                );
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
                        Navigator.pop(ctx);
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
                        onSave();
                        Navigator.pop(ctx);
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
