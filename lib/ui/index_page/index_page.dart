import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/common/widget/completed_task_item.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/ui/home_page/widgets/task_item.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  _IndexPageState();

  final List<Task> p1 = [getTask()];
  final List<Task> p2 = [getFinishedTask(), getFinishedTask()];
  final TextEditingController searchController = TextEditingController();
  final List<String> _dropdownItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String? _selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    _selectedValue = _dropdownItems[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return modeling(context);
  }

  String selectedFilter = "day";
  // modeling(p1, p2)
  Widget modeling(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //this for search widget
            Builder(builder: (context) {
              double width = MediaQuery.of(context).size.width;
              return TextInputItem2(
                hint: 'index.t1'.tr(),
                onChange: () {
                  print('search for ${searchController.text}---------------------------------');
                },
                controller: searchController,
                prefix: GestureDetector(
                  onTap: () {
                    search();
                  },
                  child: SizedBox(
                    width: 36,
                    height: 24,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SvgPicture.asset(
                        Assets.icon.icIndexSearch,
                        fit: BoxFit.cover,
                        width: 12,
                        height: 12,
                      ),
                    ),
                  ),
                ),
                width: width - 36 - 48,
              );
            }),
            const SizedBox(
              height: 20,
            ),
            filterTask(),
            const SizedBox(
              height: 16,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, position) {
                if (position < p1.length) {
                  return TaskItem(task: p1[position], category: getCategory(), onRadio: (v) {}, onTap: (t, c) {});
                }
                if (position == p1.length) {
                  return completedTag();
                }
                if (position > p1.length) {
                  return CompletedTaskItem(
                    task: p2[position - p1.length - 1],
                    category: getCategory(),
                    onTap: (t, c) {},
                    onDelete: (Task) {},
                  );
                }
                return null;
              },
              separatorBuilder: (ctx, i) => const SizedBox(
                height: 16,
              ),
              itemCount: p1.length + p2.length + 1,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget completedTag() => Row(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.20999999344348907),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Completed',
                  style: AppTextStyle.type16,
                ),
              ],
            ),
          ),
        ],
      );

  void search() {}
  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  Widget filterTask() => PopupMenuButton(
        child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedFilter,
                    style: AppTextStyle.type16,
                  ),
                  const Spacer(),
                  SvgPicture.asset(Assets.icon.icCommonsArrow)
                ],
              )),
            )),
        itemBuilder: (c) {
          return [
            PopupMenuItem(
              child: Text(
                "day",
                style: AppTextStyle.type16,
              ),
              value: 'day',
            ),
            PopupMenuItem(
              child: Text(
                "week",
                style: AppTextStyle.type16,
              ),
              value: 'week',
            ),
            PopupMenuItem(
              child: Text(
                "month",
                style: AppTextStyle.type16,
              ),
              value: 'month',
            ),
            PopupMenuItem(
              child: Text(
                "Year",
                style: AppTextStyle.type16,
              ),
              value: 'year',
            ),
          ];
        },
        onSelected: (String v) {
          //todo:do something to re filter data
          setState(() {
            selectedFilter = v;
          });
        },
      );
}
