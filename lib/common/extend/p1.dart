import 'package:easy_localization/easy_localization.dart';
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
      time: '2024-06-07T12:30:00.000',
      state: false,
      category: getCategory(),
      priority: 2,
    );

Task getFinishedTask() => Task(
      id: '1',
      label: 'Buy groceries',
      description: 'Milk, Bread, Eggs, Cheese',
      time: '2024-06-07T12:30:00.000',
      state: true,
      category: getCategory(),
      priority: 2,
    );

extension date on String {
  String toDisplayDate() {
    final DateFormat inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss'); // Example: '2023-06-27T12:30:00'

    // Parse the input date string to a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Define the output date format
    final DateFormat outputFormat = DateFormat('dd/MM/yy \'at\' HH:mm');

    // Format the DateTime object to the desired output format
    return outputFormat.format(dateTime);
  }
}

extension priority on int {
  String toDisplayPriority() {
    if (this < 4) return tr('priority.l1');
    if (this < 7) return tr('priority.l2');
    if (this < 10) return tr('priority.l3');
    return tr('priority.l4');
  }
}
