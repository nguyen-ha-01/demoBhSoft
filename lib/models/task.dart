import 'package:tiademo/models/category.dart';

class Task {
  String id;
  String label;
  String? description;
  String time;
  bool state;
  Category? category;
  int priority;
  Task({
    required this.id,
    required this.label,
    this.description,
    required this.time,
    this.state = false,
    this.category,
    this.priority = 0,
  });
  Task copyWith({
    String? id,
    String? label,
    String? description,
    String? time,
    bool? state,
    Category? category,
    int? priority,
  }) {
    return Task(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
      time: time ?? this.time,
      state: state ?? this.state,
      category: category ?? this.category,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'description': description,
      'time': time,
      'state': state ? 1 : 0,
      'categoryId': category?.id,
      'categoryName': category?.name,
      'categoryDes': category?.description,
      'categoryColorId': category?.colorId,
      'categoryIconId': category?.iconId,
      'priority': priority,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, label: $label, description: ${description ?? 'N/A'}, time: $time, state: $state, categoryId: ${category?.toMap() ?? 'N/A'}, priority: $priority}';
  }
  // factory Task.copyWith()

  factory Task.fromMap(Map<String, dynamic> map) {
    try {
      var category = Category(
          id: map['categoryId'],
          name: map['categoryName'],
          colorId: map['categoryColorId'],
          iconId: map['categoryIconId']);
      return Task(
        id: map['id'],
        label: map['label'],
        description: map['description'],
        time: map['time'],
        state: map['state'] == 1,
        category: category,
        priority: map['priority'],
      );
    } catch (e) {
      return Task(
        id: map['id'],
        label: map['label'],
        description: map['description'],
        time: map['time'],
        state: map['state'] == 1 ? true : false,
        category: null,
        priority: map['priority'],
      );
    }
  }
  Task copy() {
    return Task(
        id: this.id,
        label: this.label,
        description: this.description,
        time: this.time,
        state: this.state,
        category: category,
        priority: this.priority);
  }

  Task copyWithId(String newId) {
    return Task(
        id: newId,
        label: label,
        description: description,
        time: time,
        state: state,
        category: category,
        priority: priority);
  }
}

List<Task> filterDoneTasks(List<Task> tasks) {
  return tasks.takeWhile((value) => value.state == true).toList();
}

List<Task> filterNotDoneTasks(List<Task> tasks) {
  return tasks.where((task) => task.state == false).toList();
}
