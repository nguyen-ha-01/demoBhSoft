import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';

Category getCategory() {
  return Category(id: "1", name: "Grocery", colorId: 0xffccff80, iconId: Assets.icon.icCateGrocery);
}

Task getTask() => Task(
      id: '1',
      label: 'Buy groceries',
      description: 'Milk, Bread, Eggs, Cheese',
      time: 'Today At 16:45',
      state: false,
      categoryId: '1',
      priority: 2,
    );
Task getFinishedTask() => Task(
      id: '1',
      label: 'Buy groceries',
      description: 'Milk, Bread, Eggs, Cheese',
      time: 'Today At 16:45',
      state: true,
      categoryId: '1',
      priority: 2,
    );
