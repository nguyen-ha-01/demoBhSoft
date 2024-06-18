import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/states/task_provider.dart';

class EditTaskController extends GetxController {
  final Task rootTask;
  final Category rootCategory;
  final TaskProvider controller;
  EditTaskController(this.controller, {required this.rootTask, required this.rootCategory}) {
    tempTask.value = rootTask.copy();
    tempCategory.value = rootCategory.copy();
  }
  //temp
  var tempTask = getTask().obs;
  var tempCategory = getCategory().obs;
  var _tempCategory = getCategory().obs;

  Future<void> editTaskTitle(String label) async {
    tempTask.value.label = label;
    tempTask.refresh();
    saveChange();
  }

  Future<void> editTaskDescription(String description) async {
    tempTask.value.description = description;
    tempTask.refresh();
    saveChange();
  }

  Future<void> editTaskTime(String newTime) async {
    tempTask.value.time = newTime;
    tempTask.refresh();
    saveChange();
  }

  Future<void> editDateTime(DateTime date, TimeOfDay time) async {
    DateTime temp = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    editTaskTime(temp.toIso8601String());
  }

  void editCategoryData() {
    tempCategory.value = _tempCategory.value;
    tempCategory.refresh();
    print("-----------------category change with ${_tempCategory.value.toMap()}---------------");
    // saveChange();
  }

  void selectCategory(Category category) {
    _tempCategory.value = category;
    print("category select dialog with ${category.toMap()}---------------editTaskController");
    _tempCategory.refresh();
  }

  void editPriority(int i) {
    tempTask.value.priority = i;
    tempTask.refresh();
  }

  Future<void> saveChange() async {
    print(
        "------------------------------${tempTask.value.toMap()}save change to tedit controller ---------------------------------editTaskController ");
    tempTask.value = tempTask.value.copyWith(category: tempCategory.value);
    controller.repo.updateTask(tempTask.value);
    print(tempTask.toString());
  }

  String getTaskLabel() => tempTask.value.label;
  String getTaskDescription() => tempTask.value.description ?? "";
  String getTaskTime() => tempTask.value.time.toDisplayDate();
  Category getCategoryData() => tempCategory.value;
  int getPriority() => tempTask.value.priority;

  Future<void> deleteTask() async {
    // todo: remove task with repository then
    controller.repo.deleteTask(tempTask.value);
  }

  void rollbackData() {
    tempCategory.value = rootCategory.copy();
    tempTask.value = rootTask.copy();
    _tempCategory.value = rootCategory.copy();
    tempCategory.refresh();
    tempTask.refresh();
    _tempCategory.refresh();
    saveChange();
  }
}
