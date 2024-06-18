import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';

abstract class TaskRepository {
  Future<bool> addTask(Task task);
  Future<bool> updateTask(Task task);
  Future<bool> deleteTask(Task task);
  Future<List<Task>> getTasks();
  Future<List<Category>> getCategories();
  Future<bool> createCategory(Category category);
  Future<bool> deleteCategory(Category category);
}
