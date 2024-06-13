class Task {
  String id;
  String label;
  String? description;
  String time;
  bool state;
  String? categoryId;
  int priority;
  Task({
    required this.id,
    required this.label,
    this.description,
    required this.time,
    this.state = false,
    this.categoryId,
    this.priority = 0,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'description': description,
      'time': time,
      'state': state,
      'categoryId': categoryId,
      'priority': priority,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, label: $label, description: ${description ?? 'N/A'}, time: $time, state: $state, categoryId: ${categoryId ?? 'N/A'}, priority: $priority}';
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      label: map['label'],
      description: map['description'],
      time: map['time'],
      state: map['state'],
      categoryId: map['categoryId'],
      priority: map['priority'],
    );
  }
  Task copy() {
    return Task(
        id: this.id,
        label: this.label,
        description: this.description,
        time: this.time,
        state: this.state,
        categoryId: this.categoryId,
        priority: this.priority);
  }
}

List<Task> filterDoneTasks(List<Task> tasks) {
  return tasks.takeWhile((value) => value.state == true).toList();
}

List<Task> filterNotDoneTasks(List<Task> tasks) {
  return tasks.where((task) => task.state == false).toList();
}
