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
}
