import 'package:flutter/material.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/common/widget/category_selector_item.dart';
import 'package:tiademo/common/widget/completed_task_item.dart';
import 'package:tiademo/common/widget/custum_time_picker.dart';
import 'package:tiademo/common/widget/flag_priority_button_item.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/ui/home_page/widgets/task_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState();

  final Category category = getCategory();
  final Task task = getTask();
  bool selected = false;
  final TextEditingController text = TextEditingController();
  String st = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskItem(
          task: task,
          category: category,
          onRadio: (v) {
            setState(() {
              task.state = !task.state;
            });
            print(task.state);
          },
          onTap: (task, category) {},
        ),
        CompletedTaskItem(task: task, category: category, onTap: (task, category) {}, onDelete: (task) {}),
        PriorityButtonItem(
          onTap: () {
            setState(() {
              selected = !selected;
            });
          },
          isSelected: selected,
          value: '1',
        ),
        PriorityButtonItem(
          onTap: () {},
          isSelected: false,
          value: '1',
        ),
        const SizedBox(),
        CategorySelectorItem(
          selectedCategoryId: "1",
          category: getCategory(),
          onSelected: (e) {},
        )
      ],
    );
  }

  DateTime firstDate = DateTime(
    2024,
  );
  DateTime lastDate = DateTime(
    2100,
  );

  Future<void> pick(BuildContext c) async {
    final p = await showCustomDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);
  }
}
