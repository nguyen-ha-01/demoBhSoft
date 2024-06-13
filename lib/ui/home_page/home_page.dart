import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tiademo/common/widget/appbar.dart';
import 'package:tiademo/common/widget/bottom_nav.dart';
import 'package:tiademo/common/widget/custum_time_picker.dart';
import 'package:tiademo/common/widget/pages/category_select_page.dart';
import 'package:tiademo/common/widget/pages/custom_hour_picker.dart';
import 'package:tiademo/common/widget/pages/priority_select_page.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/states/add_task_controller.dart';
import 'package:tiademo/states/cubit/nav.dart';
import 'package:tiademo/ui/calender_page/calender_page.dart';
import 'package:tiademo/ui/focus_page/focus_page.dart';
import 'package:tiademo/ui/index_page/index_page.dart';
import 'package:tiademo/ui/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AddTaskController controller = Get.put(AddTaskController());
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider<NavCubit>(
        create: (BuildContext ctx) => getIt<NavCubit>(),
        child: Scaffold(
          appBar: CustomAppBar(
            action: () {},
            url: null,
          ),
          body: BlocBuilder<NavCubit, NavBarState>(
            builder: (context, state) {
              return IndexedStack(
                index: NavBarState.values.indexOf(state),
                children: const [IndexPage(), CalenderPage(), FocusPage(), ProfilePage()],
              );
            },
          ),
          bottomNavigationBar: const BottomNavBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var isAdded = await Get.bottomSheet(bottomSheetModeling());
                if (isAdded == true) {
                  //todo: reload data
                }
              },
              child: SvgPicture.asset(Assets.icon.icHomeNav5)),
        ),
      ),
    );
  }

  Widget bottomSheetModeling() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColor.dialog_background,
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('home.l3'),
                style: AppTextStyle.type24.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextInputItem(hint: tr('home.t1'), onChange: (v) {}, controller: controller.title.value),
              const SizedBox(
                height: 13,
              ),
              TextInputItem(
                hint: tr('home.t2'),
                onChange: (v) {},
                controller: controller.description.value,
                maxLine: 3,
              ),
              // Expanded(
              //     child:
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    timePick(),
                    const SizedBox(
                      width: 14,
                    ),
                    categoryPick(),
                    const SizedBox(
                      width: 14,
                    ),
                    priorityPick(),
                    const Spacer(),
                    addTaskBtn(),
                  ],
                ),
              )
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget timePick() => Builder(builder: (context) {
        return GestureDetector(
          onTap: () async {
            //todo: time pick btn in add task
            var date = await showCustomDatePicker(
                context: context,
                firstDate: DateTime(2024),
                lastDate: DateTime(2050),
                cancelLabel: tr('picker.b1'),
                submitLabel: tr('picker.b2'));
            if (date != null) {
              print("date picked is ${date.toString()}");
              controller.setDate(date);
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
                controller.setTime(time);
              }
            }
          },
          child: SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              Assets.icon.icHomeSheetTimer,
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          ),
        );
      });

  Widget categoryPick() => GestureDetector(
        onTap: () async {
          //todo: add tag in sheet
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (c) => Obx(() => categorySelectedPage(context, controller.getCategories(),
                  (p) => controller.selectCategory(p), () => {controller.saveCategory()})));
        },
        child: SizedBox(
          width: 40,
          height: 40,
          child: SvgPicture.asset(
            Assets.icon.icHomeSheetTag,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
          ),
        ),
      );

  Widget priorityPick() => Builder(builder: (context) {
        return GestureDetector(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (ctx) {
                  controller.selectedPriority.value = controller.priority.value;
                  return Obx(() => prioritySelectPage(context, (e) => controller.selectPriority(e),
                      controller.selectedPriority.value, () => controller.setPriority()));
                });
          },
          child: SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              Assets.icon.icHomeSheetFlag,
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          ),
        );
      });

  Widget addTaskBtn() => GestureDetector(
        onTap: () async {
          //todo: icon sheet Send
          var isAdded = await controller.addTask();
          if (isAdded) {
            Navigator.pop(context, true);
          }
        },
        child: SizedBox(
          width: 40,
          height: 40,
          child: SvgPicture.asset(
            Assets.icon.iconHomeSheetSend,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
          ),
        ),
      );
}
