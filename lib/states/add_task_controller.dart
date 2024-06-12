import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/priority.dart';

class AddTaskController extends GetxController {
  var title = TextEditingController().obs;
  var description = TextEditingController().obs;
  var priority = MePriority.mode_default.obs;
  var selectedPriority = MePriority.mode_default.obs;
  var category = Category.empty().obs;
  var selectedCategory = Category.empty().obs;
  RxList<Category> categories = RxList([getCategory(), getCategory(), getCategory()]);
  //time
  var datePicked = DateTime(2024).obs;
  var timePicked = TimeOfDay(hour: 0, minute: 0).obs;

  void setDate(DateTime time) {
    datePicked.value = time;
    print("controller ${datePicked.value.toString()}");
  }

  Future<bool> addTask() async {
    //todo:addTask
    return true;
  }

  void addCategory(Category category) {
    categories.add(category);
    update();
    print("add category_----------------------------------");
  }

  void setTime(TimeOfDay t) {
    timePicked.value = t;
    print("controller ${timePicked.value.toString()}");
  }

  //categoty
  List<Category> getCategories() => categories.value;
  void selectCategory(Category p) {
    selectedCategory.value = p;
    print("controller ${selectedCategory.value.toString()}");
  }

  void saveCategory() {
    category.value = selectedCategory.value;
    print("controller ${category.value.toString()}");
  }

  //priority
  void selectPriority(int p) {
    selectedPriority.value = p;
    // print(selectedPriority.value);
  }

  void setPriority() {
    priority.value = selectedPriority.value;
    print("controller ${title.value.text.toString()}");
    print("controller ${description.value.text.toString()}");
    print("controller ${priority.value.toString()}");
  }
}
