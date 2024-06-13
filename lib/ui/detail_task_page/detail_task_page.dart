import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/common/widget/custum_time_picker.dart';
import 'package:tiademo/common/widget/pages/category_select_page.dart';
import 'package:tiademo/common/widget/pages/custom_hour_picker.dart';
import 'package:tiademo/common/widget/pages/priority_select_page.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/states/add_task_controller.dart';
import 'package:tiademo/states/edit_task_controller.dart';
import 'package:tiademo/ui/detail_task_page/widgets/delete_task.dart';
import 'package:tiademo/ui/detail_task_page/widgets/edit_task_title.dart';
import 'package:tiademo/ui/home_page/home_page.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({super.key, required this.task, required this.category});

  final Task task;
  final Category category;

  @override
  _DetailTaskPageState createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  _DetailTaskPageState();

  late EditTaskController _controller;
  final AddTaskController _addTaskController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    _controller = Get.put(EditTaskController(rootTask: widget.task, rootCategory: widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Expanded(
        child: SafeArea(
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
                Obx(() => taskTime(_controller.getTaskTime())),
                const SizedBox(
                  height: 37,
                ),
                Obx(() => taskCategory(_controller.getCategoryData())),
                const SizedBox(
                  height: 27,
                ),
                Obx(() => taskPriority(_controller.getPriority())),
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
        onTap: () {
          _controller.saveChange();
          Get.back();
        },
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

  Widget taskTime(String time) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.icon.icHomeSheetTimer,
            fit: BoxFit.contain,
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l1'.tr(),
            style: AppTextStyle.type16,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              //todo: show time change dialog
              var date = await showCustomDatePicker(
                  context: context,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2050),
                  cancelLabel: tr('picker.b1'),
                  submitLabel: tr('picker.b2'));
              if (date != null) {
                print("date picked is ${date.toString()}");

                // var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                var hourPicker = HourPicker(
                  handleCancel: () {
                    Navigator.pop(context);
                  },
                  handleOk: (h, m, ap) {
                    TimeOfDay t = TimeOfDay(hour: (ap == 'am') ? h : h + 12, minute: m);
                    Navigator.pop(context, t);
                  },
                );
                var time = await showDialog(context: context, builder: (c) => hourPicker);

                if (time != null && time is TimeOfDay) {
                  print("time picked is ${time.toString()}");
                  _controller.editDateTime(date, time);
                }
              }
            },
            child: Container(
              height: 37,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.dialog_background),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  _controller.tempTask.value.label,
                  style: AppTextStyle.type20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() => Text(
                    _controller.tempTask.value.description ?? "",
                    style: AppTextStyle.type16.copyWith(color: AppColor.border),
                  ))
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              var change = await editContentTask();
              if (change != null) {
                //todo:update task
                String? title = change['title'];
                String? description = change['description'];
                if (title != null) {
                  _controller.editTaskTitle(title);
                  print('title edited with $title');
                }
                if (description != null) {
                  _controller.editTaskDescription(description);
                  print('description edit with $description');
                }
                print("detail_task_get_data after edit with $change");
              }
            },
            child: SvgPicture.asset(
              Assets.icon.icDetailEdit,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
          )
        ],
      );

  Widget appBarBtn() => Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColor.btnColor),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  Assets.icon.icDetailExit,
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              rollback();
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColor.btnColor),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  Assets.icon.icDetailRollback,
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )
        ],
      );

  void rollback() {
    _controller.rollbackData();
  }

  Widget taskCategory(Category category) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.icon.icHomeSheetTag,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l2'.tr(),
            style: AppTextStyle.type16,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              //todo: Show category change
              await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (c) => categorySelectedPage(context, _addTaskController.categories,
                      (p) => _controller.selectCategory(p), () => {_controller.editCategoryData()}));
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.dialog_background),
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(category.iconId),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      category.name,
                      style: AppTextStyle.type12_cate,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
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
          SvgPicture.asset(
            Assets.icon.icHomeSheetFlag,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l3'.tr(),
            style: AppTextStyle.type16,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (ctx) {
                    _addTaskController.selectedPriority.value = _addTaskController.priority.value;
                    return Obx(() => prioritySelectPage(context, (e) => _addTaskController.selectPriority(e),
                            _addTaskController.selectedPriority.value, () {
                          _addTaskController.setPriority();
                          _controller.editPriority(_addTaskController.selectedPriority.value);
                        }));
                  });
            },
            child: Container(
              height: 37,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.dialog_background),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: Text(
                  priority.toDisplayPriority(),
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
          SvgPicture.asset(
            Assets.icon.icDetailSub,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l4'.tr(),
            style: AppTextStyle.type16,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //todo: show priority change dialog
            },
            child: Container(
              height: 37,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.dialog_background),
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
        onTap: () async {
          //todo: on delete task
          //this will remove task and navigate back to home
          bool? willDelete = await showDialog(
              context: context,
              builder: (c) => DeleteTask(
                    title: _controller.getTaskLabel(),
                  ));
          if (willDelete == true) {
            _controller.deleteTask();
            Get.offAll(() => const HomePage());
          }
        },
        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
          SvgPicture.asset(
            Assets.icon.icCommonTrash,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'detail.l6'.tr(),
            style: AppTextStyle.type20.copyWith(color: AppColor.alert),
          ),
        ]),
      );

  Future<Map<String, dynamic>?> editContentTask() async {
    return await showDialog(
        context: context,
        builder: (_) {
          return EditTaskTitle(
            title: widget.task.label,
            description: widget.task.description,
          );
        });
  }
}
