import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/repository/task_repository_impl.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/models/user.dart';
import 'package:tiademo/states/state/base_state.dart';

class TaskProvider extends ChangeNotifier {
  TaskRepositoryImpl repo = TaskRepositoryImpl();
  ApiResponse<UserData>? authState;
  ApiResponse<List<Task>> tasksState = ApiResponse.init("haven't load tasks yet");
  ApiResponse<List<Category>> categoriesState = ApiResponse.init("haven't load categories yet");

  String selectedFilter = '';
  List<String> taskFilters = [];

  factory TaskProvider.withToken(ApiResponse<UserData> authState) {
    return TaskProvider(auth_State: authState, repo: TaskRepositoryImpl(token: authState.data?.token));
  }

  void init() {
    authState = ApiResponse.init('');
    taskFilters.addAll([tr('index.b1'), tr('index.b2'), tr('index.b3'), tr('index.b4')]);
    notifyListeners();
  }

  Future<void> update(ApiResponse<UserData> newAuth) async {
    authState = newAuth;
    // notifyListeners();
    if (newAuth.status == Status.COMPLETED) {
      authState = newAuth;
      if (authState?.data != null) {
        repo.updateToken(authState?.data?.token);
        var tasks = await repo.getTasks();
        tasksState = ApiResponse.completed(tasks);
        notifyListeners();
      }
    }
  }

  TaskProvider({ApiResponse<UserData>? auth_State, required TaskRepositoryImpl repo})
      : repo = repo,
        authState = auth_State;

  Future<void> loadTasks() async {
    try {
      tasksState = ApiResponse.loading("start Loading");
      notifyListeners();
      print("start loading------------------------------provider");
      var tasks = await repo.getTasks();
      tasksState = ApiResponse.completed(tasks);
      notifyListeners();
      print(" loaded------------------------------provider");
    } on Exception catch (e) {
      e.printError();
      tasksState = ApiResponse.error("can load task---------------taskProvider");
      notifyListeners();
      print("can load task---------------taskProvider");
    }
  }

  Future<void> loadCategories() async {}

  Future<bool> updateTask(Task task) async {
    return true;
  }

  Future<bool> syncData() async {
    if (repo.token != null) {
      return await repo.syncData();
      print("synced with token${repo.token}---------------------------------------");
    } else {
      return false;
    }
  }
}
