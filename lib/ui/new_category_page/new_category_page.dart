import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/states/add_category.dart';

class NewCategoryPage extends StatefulWidget {
  NewCategoryPage({super.key});

  @override
  State<NewCategoryPage> createState() => _NewCategoryPageState();
}

class _NewCategoryPageState extends State<NewCategoryPage> {
  // final List<int> colors = [0xff8687E7, 0xff8687E7, 0xff8687E7, 0xff696969];
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddCategory>(
      create: (c) => getIt<AddCategory>()..init(),
      child: Builder(builder: (c) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    tr('category.h1'),
                    style: AppTextStyle.type24,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    tr('category.l1'),
                    style: AppTextStyle.type20,
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
                    onChange: (String) {},
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(tr('category.l2'), style: AppTextStyle.type20),
                  const SizedBox(
                    height: 10,
                  ),
                  setIcon(),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(tr('category.l3'), style: AppTextStyle.type20),
                  const SizedBox(
                    height: 8,
                  ),
                  Consumer<AddCategory>(builder: (c, p, _) {
                    var colors = p.getColors();

                    return SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) {
                          return GestureDetector(
                            onTap: () {
                              p.setColor(colors[i]);
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(colors[i]),
                                  border: (p.getColor() == colors[i]) ? Border.all(color: AppColor.white) : null),
                            ),
                          );
                        },
                        separatorBuilder: (c, p) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: colors.length,
                        shrinkWrap: true,
                      ),
                    );
                    return Container();
                  }),
                  const Spacer(),
                  Consumer<AddCategory>(builder: (c, p, _) {
                    return groupButton(p);
                  })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void alert(String mes) {
    print(mes);
  }

  Category? getData(AddCategory p) {
    bool pass = true;
    if (p.getIconSrc().isEmpty) {
      pass = false;
      print("no icon");
    }
    if (nameController.text.isEmpty) {
      pass = false;
      print("no title");
    }
    if (pass) {
      String n = nameController.text;
      return Category(id: n, name: n, colorId: p.getColor(), iconId: p.getIconSrc());
    }
    return null;
  }

  Widget groupButton(AddCategory p) => Padding(
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
                    //todo: passing data
                    var data = getData(p);
                    if (data != null) {
                      Navigator.pop(context, data as Category);
                    } else {
                      print("error");
                    }
                  },
                  child: SizedBox(
                      height: 48,
                      child: Center(
                          child: Text(
                        'category.b2'.tr(),
                        style: AppTextStyle.type20,
                      )))),
            )
          ],
        ),
      );

  Widget setIcon() => Consumer<AddCategory>(builder: (c, p, _) {
        if (p.getIconSrc().isNotEmpty) {
          return InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  p.getIconSrc(),
                  placeholderBuilder: (context) => Container(),
                ),
              ),
            ),
          );
        } else {
          return ElevatedButton(
              onPressed: () async {
                var src = await Future.delayed(const Duration(seconds: 1), () => Assets.icon.icCateMusic);
                if (src is String) {
                  p.setIconSrc(src);
                }
              },
              child: const Text('category.l5'));
        }
        return Container();
      });
}
