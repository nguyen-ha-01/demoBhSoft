import 'dart:core';

import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/repository/abstract/task_repository.dart';
import 'package:tiademo/models/task.dart';

class TaskRepositoryImpl extends TaskRepository {
  String? token;
  void updateToken(String? newToken) {
    token = newToken;
  }

  TaskRepositoryImpl({this.token});
  @override
  Future<bool> addTask(Task task) async {
    // TODO: implement addTask
    return false;
  }

  @override
  Future<bool> createCategory(Category category) async {
    // TODO: implement createCategory

    return false;
  }

  @override
  Future<bool> deleteTask(Task task) async {
    // TODO: implement deleteTask
    return false;
  }

  @override
  Future<List<Category>> getCategories() async {
    // TODO: implement getCategories
    return [];
  }

  @override
  Future<List<Task>> getTasks() async {
    // TODO: implement getTasks
    return [];
  }

  @override
  Future<bool> updateTask(String id, Task task) async {
    // TODO: implement updateTask
    return false;
  }

  @override
  Future<bool> deleteCategory(Category category) async {
    // TODO: implement deleteCategory
    return false;
  }
}
