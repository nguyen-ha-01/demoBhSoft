import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/common/widget/category_item.dart';
import 'package:tiademo/common/widget/priority_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/routes/named_route.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final Category category;
  final Function(bool?) onRadio;
  final Function(Task, Category) onTap;

  const TaskItem({super.key, required this.task, required this.category, required this.onRadio, required this.onTap});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (widget.task.state == false) ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      child: InkWell(
        onTap: () {
          Map<String, dynamic> args = {'task': widget.task, 'category': widget.category};
          Get.toNamed(NamedRoutes.detail_task_page, arguments: args);
          print("start detail map${args.toString()}");
        },
        child: Container(
          height: 72,
          decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Radio<bool>(
                value: !widget.task.state,
                groupValue: widget.task.state,
                onChanged: (value) {
                  widget.onRadio(value);
                },
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.label,
                      style: AppTextStyle.type16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.time.toDisplayDate(),
                          style: AppTextStyle.type14_low,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CategoryItem(
                              category: widget.category.name,
                              asset: widget.category.iconId,
                              color: widget.category.colorId,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            PriorityItem(value: widget.task.priority.toString())
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
