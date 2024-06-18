import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/common/widget/completed_task_item.dart';
import 'package:tiademo/common/widget/pages/error_page.dart';
import 'package:tiademo/common/widget/pages/loading_page.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/states/state/base_state.dart';
import 'package:tiademo/states/task_provider.dart';
import 'package:tiademo/ui/home_page/widgets/blank_item.dart';
import 'package:tiademo/ui/home_page/widgets/task_item.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  IndexPageState();

  final TextEditingController searchController = TextEditingController();
  final List<String> _dropdownItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String? _selectedValue;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _selectedValue = _dropdownItems[1];
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _firstLoadTask();
    // });
  }

  _firstLoadTask() async {
    context.read<TaskProvider>().loadTasks();
  }

  String selectedFilter = "day";

  @override
  Widget build(BuildContext context) {
    return modeling(context);
  }

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
                  if (kDebugMode) {
                    print('search for ${searchController.text}---------------------------------');
                  }
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
            Consumer<TaskProvider>(builder: (ctx, provider, _) {
              if (provider.tasksState.status == Status.COMPLETED) {
                if (provider.tasksState.data!.isEmpty) {
                  return const Center(
                    child: BlankItem(),
                  );
                }
                var p2 = filterDoneTasks(provider.tasksState.data!);
                var p1 = filterNotDoneTasks(provider.tasksState.data!);

                return _listTaskItemLoadSuccess(p1, p2);
              }
              if (provider.tasksState.status == Status.LOADING) {
                return const LoadingPage();
              }
              if (provider.tasksState.status == Status.ERROR) {
                return const ErrorPage();
              }
              return const Center(child: BlankItem());
            }),
          ],
        ),
      ),
    );
  }

  Widget _listTaskItemLoadSuccess(List<Task> notDone, List<Task> done) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (c, position) {
        if (position < notDone.length) {
          print("indexpage---------dataTask with${notDone[position].toMap()}------------");
          return Builder(builder: (context) {
            var p = getCategory();
            return TaskItem(
                task: notDone[position],
                category: notDone[position].category ?? p,
                onRadio: (v) {},
                onTap: (t, category) {});
          });
        }
        if (position == notDone.length) {
          return completedTag();
        }
        if (position > notDone.length) {
          return CompletedTaskItem(
            task: done[position - notDone.length - 1],
            category: getCategory(),
            onTap: (t, c) {},
            onDelete: (Task t) {},
          );
        }
        return Container();
      },
      separatorBuilder: (ctx, i) => const SizedBox(
        height: 16,
      ),
      itemCount: notDone.length + done.length + 1,
      shrinkWrap: true,
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
              value: 'day',
              child: Text(
                "day",
                style: AppTextStyle.type16,
              ),
            ),
            PopupMenuItem(
              value: 'week',
              child: Text(
                "week",
                style: AppTextStyle.type16,
              ),
            ),
            PopupMenuItem(
              value: 'month',
              child: Text(
                "month",
                style: AppTextStyle.type16,
              ),
            ),
            PopupMenuItem(
              value: 'year',
              child: Text(
                "Year",
                style: AppTextStyle.type16,
              ),
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
