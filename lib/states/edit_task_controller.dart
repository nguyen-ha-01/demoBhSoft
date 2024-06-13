import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';

class EditTaskController extends GetxController {
  final Task rootTask;
  final Category rootCategory;
  EditTaskController({required this.rootTask, required this.rootCategory}) {
    tempTask.value = rootTask.copy();
    tempCategory.value = rootCategory.copy();
  }
  //temp
  var tempTask = getTask().obs;
  var tempCategory = getCategory().obs;
  var _tempCategory = getCategory().obs;

  void editTaskTitle(String label) {
    tempTask.value.label = label;
    tempTask.refresh();
  }

  void editTaskDescription(String description) {
    tempTask.value.description = description;
    tempTask.refresh();
  }

  void editTaskTime(String newTime) {
    tempTask.value.time = newTime;
    tempTask.refresh();
  }

  void editDateTime(DateTime date, TimeOfDay time) {
    DateTime temp = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    tempTask.value.time = temp.toIso8601String();
    tempTask.refresh();
  }

  void editCategoryData() {
    tempCategory.value = _tempCategory.value;
    tempCategory.refresh();
  }

  void selectCategory(Category category) {
    _tempCategory.value = category;
    _tempCategory.refresh();
  }

  void editPriority(int i) {
    tempTask.value.priority = i;
    tempTask.refresh();
  }

  void saveChange() {
    print("edit task to ");
    print(tempTask.toString());
  }

  String getTaskLabel() => tempTask.value.label;
  String getTaskDescription() => tempTask.value.description ?? "";
  String getTaskTime() => tempTask.value.time.toDisplayDate();
  Category getCategoryData() => tempCategory.value;
  int getPriority() => tempTask.value.priority;

  void deleteTask() {
    // todo: remove task with repository then
  }

  void rollbackData() {
    tempCategory.value = rootCategory.copy();
    tempTask.value = rootTask.copy();
    _tempCategory.value = rootCategory.copy();
    tempCategory.refresh();
    tempTask.refresh();
    _tempCategory.refresh();
  }
}
