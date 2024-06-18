import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/priority.dart';
import 'package:tiademo/models/repository/task_repository_impl.dart';
import 'package:tiademo/models/task.dart';

class AddTaskController extends GetxController {
  var title = TextEditingController().obs;
  var description = TextEditingController().obs;
  var priority = MePriority.mode_default.obs;
  var selectedPriority = MePriority.mode_default.obs;
  var category = Category.empty().obs;
  var selectedCategory = Category.empty().obs;
  final TaskRepositoryImpl repository;

  RxList<Category> categories = RxList([]);
  //time
  var datePicked = DateTime(2024).obs;
  var timePicked = TimeOfDay(hour: 0, minute: 0).obs;

  AddTaskController(this.repository);

  void setDate(DateTime time) {
    datePicked.value = time;
    print("controller ${datePicked.value.toString()}");
  }

  void setTime(TimeOfDay t) {
    timePicked.value = t;
    print("controller ${timePicked.value.toString()}");
  }

  Future<bool> addTask() async {
    //todo:addTask
    DateTime time = DateTime(datePicked.value.year, datePicked.value.month, datePicked.value.day, timePicked.value.hour,
        timePicked.value.minute);
    Task task = Task(
        id: "000000",
        label: title.value.text,
        time: time.toIso8601String(),
        description: description.value.text,
        state: false,
        category: category.value,
        priority: priority.value);
    var out = await repository.addTask(task);
    clean();
    return out;
  }

  void clean() {
    print("clean controller temp data after add");
    title.value.clear();
    title.refresh();
    description.value.clear();
    description.refresh();
    selectedPriority.value = 1;
    selectedPriority.refresh();
  }

  //priority
  void selectPriority(int p) {
    selectedPriority.value = p;
    selectedPriority.refresh();
    // print(selectedPriority.value);
  }

  void setPriority() {
    priority.value = selectedPriority.value;
    priority.refresh();
    print("controller ${title.value.text.toString()}");
    print("controller ${description.value.text.toString()}");
    print("controller ${priority.value.toString()}");
  }

  ///add category

  Future<List<Category>> getCategories() async {
    var data = await repository.getCategories();
    categories.clear();
    categories.addAll(data);
    return categories.value;
  }

  void selectCategory(Category p) {
    selectedCategory.value = p;
    selectedCategory.refresh();
    print("controller ${selectedCategory.value.toString()}");
  }

  Future<void> addCategory(Category category) async {
    var isAdded = await repository.createCategory(category);
    if (isAdded) {
      //reload category again
      categories.clear();
      var reload = await repository.getCategories();
      categories.addAll(reload);
      categories.refresh();
    }
    // categories.add(category);
    // categories.refresh();
    print("add category_----------------------------------");
  }

  void saveCategory() {
    category.value = selectedCategory.value;
    category.refresh();
    print("controller ${category.value.toString()}");
  }

  var colors = [
    0xfffff111,
    0xff9ff111,
    0xff6ff111,
    0xff7ff111,
    0xff8ff111,
    0xfffff111,
    0xff9ff111,
    0xff6ff111,
    0xff7ff111,
    0xff8ff111,
    0xfffff111,
    0xff9ff111,
    0xff6ff111,
    0xff7ff111,
    0xff8ff111
  ];
  var iconSrcs = [
    Assets.icon.icCateDesign,
    Assets.icon.icCateGrocery,
    Assets.icon.icCateHeath,
    Assets.icon.icCateMusic,
    Assets.icon.icCateSocial,
    Assets.icon.icCateSport,
    Assets.icon.icCateUniver,
    Assets.icon.icCateWork,
    Assets.icon.iconCateMovie
  ];
  var selectedColorPos = (-1).obs;
  Rx<int> selectedIconPos = (-1).obs;

  Rx<int> selectedIcon = (-1).obs;

  var newCategoryTitle = "".obs;
  void createCategory() {
    if (selectedColorPos.value != -1) {
      if (selectedIcon.value != -1) {
        if (newCategoryTitle.isNotEmpty) {
          var temp = Category(
              id: newCategoryTitle.value,
              name: newCategoryTitle.value,
              colorId: colors[selectedColorPos.value],
              iconId: iconSrcs[selectedIcon.value]);
          addCategory(temp);
          newCategoryTitle.value = "";
          selectedColorPos.value = -1;
          selectedIconPos.value = -1;
          selectedIcon.value = -1;
        } else {}
      } else {}
    } else {}
  }

  void setIconOnCreateCategory() {
    selectedIcon.value = selectedIconPos.value;
    update();
    print("selectedicon is ${selectedIcon.value}");
  }
}
