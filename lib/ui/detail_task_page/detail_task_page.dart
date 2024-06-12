import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({super.key, required this.task, required this.category});

  final Task task;
  final Category category;

  @override
  _DetailTaskPageState createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  _DetailTaskPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                appBarBtn(),
                const SizedBox(
                  height: 25,
                ),
                dataTask(),
                const SizedBox(
                  height: 40,
                ),
                taskTime(widget.task.time),
                const SizedBox(
                  height: 37,
                ),
                taskCategory(widget.category),
                const SizedBox(
                  height: 27,
                ),
                taskPriority(widget.task.priority),
                const SizedBox(
                  height: 27,
                ),
                subTask(),
                const SizedBox(
                  height: 30,
                ),
                deleteTask(),
                const Spacer(),
                finishTask()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget finishTask() => GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(color: AppColor.primary, borderRadius: BorderRadius.circular(10)),
          child: Align(
            child: Text(
              'detail.l7'.tr(),
              style: AppTextStyle.type24,
            ),
          ),
        ),
      );

  Widget taskTime(time) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            color: AppColor.primary,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l1'.tr(),
            style: AppTextStyle.type20,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //todo: show time change dialog
            },
            child: Container(
              height: 37,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.primary),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: Text(
                  time,
                  style: AppTextStyle.type16,
                ),
              ),
            ),
          )
        ],
      );

  Widget dataTask() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.label,
                  style: AppTextStyle.type20,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.task.description ?? " ",
                  style: AppTextStyle.type20,
                )
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              width: 32,
              height: 32,
              color: Colors.white,
            ),
          )
        ],
      );

  Widget appBarBtn() => Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColor.primary),
          ),
          const Spacer(),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColor.primary),
          )
        ],
      );

  Widget taskCategory(Category category) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            color: AppColor.primary,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l2'.tr(),
            style: AppTextStyle.type20,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //todo: Show category change
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.primary),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(category.iconId),
                    Text(
                      category.name,
                      style: AppTextStyle.type12_cate,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );

  Widget taskPriority(int priority) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            color: AppColor.primary,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l3'.tr(),
            style: AppTextStyle.type20,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //todo: show priority change dialog
            },
            child: Container(
              height: 37,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.primary),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: Text(
                  priority == 1 ? 'detail.default'.tr() : priority.toString(),
                  style: AppTextStyle.type16,
                ),
              ),
            ),
          )
        ],
      );

  Widget subTask() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            color: AppColor.primary,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l4'.tr(),
            style: AppTextStyle.type20,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //todo: show priority change dialog
            },
            child: Container(
              height: 37,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.primary),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: Text(
                  'detail.l5'.tr(),
                  style: AppTextStyle.type16,
                ),
              ),
            ),
          )
        ],
      );

  Widget deleteTask() => GestureDetector(
        onTap: () {
          //todo: on delete task
        },
        child: Container(
          child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 30,
              height: 30,
              color: AppColor.primary,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'detail.l5'.tr(),
              style: AppTextStyle.type20.copyWith(color: AppColor.alert),
            ),
          ]),
        ),
      );
}
