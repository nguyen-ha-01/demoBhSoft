import 'package:flutter/material.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/common/widget/completed_task_item.dart';
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
          CompletedTaskItem(task: task, category: category, onTap: (task, category) {}, onDelete: (task) {})
        ],
      ),
    );
  }
}
