import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/gen/assets.gen.dart';
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

  void setTime(TimeOfDay t) {
    timePicked.value = t;
    print("controller ${timePicked.value.toString()}");
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

  List<Category> getCategories() => categories.value;
  void selectCategory(Category p) {
    selectedCategory.value = p;
    selectedCategory.refresh();
    print("controller ${selectedCategory.value.toString()}");
  }

  void addCategory(Category category) {
    categories.add(category);
    categories.refresh();
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
