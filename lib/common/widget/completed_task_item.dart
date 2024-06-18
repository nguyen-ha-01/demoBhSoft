import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/routes/named_route.dart';

class CompletedTaskItem extends StatefulWidget {
  final Task task;
  final Category category;
  final Function(Task, Category) onTap;
  final Function(Task) onDelete;

  const CompletedTaskItem(
      {super.key, required this.task, required this.category, required this.onTap, required this.onDelete});
  @override
  _CompletedTaskItemState createState() => _CompletedTaskItemState();
}

class _CompletedTaskItemState extends State<CompletedTaskItem> {
  bool willShowDeleteBtn = false;
  final double showWidth = 74;
  double _dragPosition = 0;

  _CompletedTaskItemState();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (widget.task.state != false) ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      child: GestureDetector(
        onTap: () {
          Map<String, dynamic> args = {'task': widget.task, 'category': widget.category};
          Get.toNamed(NamedRoutes.detail_task_page, arguments: args);
          print("start detail map${args.toString()}");
        },
        onHorizontalDragUpdate: (detail) {
          setState(() {
            _dragPosition += detail.delta.dx;
            if (_dragPosition < 0) {
              willShowDeleteBtn = true;
            }
            if (_dragPosition > 15) {
              willShowDeleteBtn = false;
            }
          });
        },
        child: Container(
          height: 72,
          decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Radio<bool>(
                  value: !widget.task.state,
                  groupValue: widget.task.state,
                  onChanged: (value) {},
                ),
              ),
              // const SizedBox(
              //   width: 12,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                          Expanded(
                            child: Text(
                              widget.task.time.toDisplayDate(),
                              style: AppTextStyle.type14_low,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: widget.onDelete(widget.task),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffc2c1c1).withOpacity(willShowDeleteBtn ? 1 : 0),
                        borderRadius:
                            const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))),
                    width: (willShowDeleteBtn) ? showWidth : 0,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        Assets.icon.icCommonTrash,
                        fit: BoxFit.scaleDown,
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
