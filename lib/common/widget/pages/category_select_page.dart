import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:tiademo/common/widget/category_selector_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/states/add_task_controller.dart';
import 'package:tiademo/ui/new_category_page/new_category_page.dart';

Widget categorySelectedPage(
    BuildContext ctx, List<Category> categories, Function(Category) onSelectCategory, Function() onSave) {
  Widget categorySelectItem(Category category) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onSelectCategory(category),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: Color(category.colorId), borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  category.iconId,
                  width: 32,
                  height: 32,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(
            category.name,
            style: AppTextStyle.type14,
          )
        ],
      );
  AddTaskController controller = Get.find<AddTaskController>();
  return Dialog(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr('commons.l4'),
            style: AppTextStyle.type20.copyWith(fontWeight: FontWeight.w700),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Divider(
              color: AppColor.border,
              height: 1,
            ),
          ),
          Obx(() => GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Số cột
                crossAxisSpacing: 4.0, // Khoảng cách giữa các cột
                mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
              ),
              itemCount: controller.categories.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.categories.length) {
                  return CategoryCreateBtn(onSelected: () async {
                    //Navigator.push(context, MaterialPageRoute(builder: (c) => NewCategoryPage()));
                    var data = await showDialog(context: context, builder: (c) => NewCategoryPage());
                    if (data is Category) {
                      controller.addCategory(data);
                      print("have data back");
                    }
                  });
                }
                return CategorySelectorItem(
                  category: controller.categories[index],
                  onSelected: (e) {
                    onSelectCategory(e);
                  },
                );
              })),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(ctx, "asv");
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
//
// Widget categorySelectedPage(BuildContext ctx, List<Category> categories, Category selectedCategory,
//     Function(Category) onSelectCategory, Function() onSave) {
//   return Dialog(
//     child: Container(
//       width: 330,
//       height: 400,
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Column(
//           children: [
//             Text(
//               'commons.l4'.tr(),
//               style: AppTextStyle.type24.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Divider(
//                 color: AppColor.border,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4, // Số cột
//                   crossAxisSpacing: 4.0, // Khoảng cách giữa các cột
//                   mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
//                 ),
//                 itemCount: categories.length + 1,
//                 itemBuilder: (context, index) {
//                   // return Container(child: Text(categories[index].name));
//                   if (index == categories.length) {
//                     return CategoryCreateBtn(onSelected: () {
//                       print("click");
//                       Navigator.push(context, MaterialPageRoute(builder: (c) => const NewCategoryPage()));
//                       print("but");
//                     });
//                   }
//                   return CategorySelectorItem(
//                     selectedCategoryId: selectedCategory.id,
//                     category: categories[index],
//                     onSelected: (e) {
//                       onSelectCategory(e);
//                     },
//                   );
//                 },
//               ),
//             ),
//             if (categories.isNotEmpty)
//               Text(
//                 categories.length.toString() ?? "cccc",
//                 style: AppTextStyle.type24,
//               ),
//             Padding(
//               padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.pop(ctx);
//                         },
//                         child: SizedBox(
//                             height: 48,
//                             child: Center(
//                                 child: Text(
//                               'commons.l2'.tr(),
//                               style: AppTextStyle.type20,
//                             )))),
//                   ),
//                   Expanded(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           onSave();
//                           Navigator.pop(ctx);
//                         },
//                         child: SizedBox(
//                             height: 48,
//                             child: Center(
//                                 child: Text(
//                               'commons.l3'.tr(),
//                               style: AppTextStyle.type20,
//                             )))),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
