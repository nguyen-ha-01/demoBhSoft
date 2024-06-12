import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiademo/models/repository/task_repository_impl.dart';
import 'package:tiademo/models/user.dart';
import 'package:tiademo/states/state/base_state.dart';

class TaskProvider extends ChangeNotifier {
  TaskRepositoryImpl? _repo;
  ApiResponse<UserData>? authState;
  String selectedFilter = '';
  List<String> taskFilters = [];
  factory TaskProvider.withToken(ApiResponse<UserData> authState) {
    return TaskProvider(auth_State: authState, repo: TaskRepositoryImpl(token: authState.data?.token));
  }

  void init() {
    _repo = TaskRepositoryImpl();
    authState = ApiResponse.init('');
    taskFilters.addAll([tr('index.b1'), tr('index.b2'), tr('index.b3'), tr('index.b4')]);
    notifyListeners();
  }

  void update(ApiResponse<UserData> new_authState) {
    authState = new_authState;
    // notifyListeners();
    _repo?.updateToken(authState?.data?.token);
    notifyListeners();
    reload();
  }

  TaskProvider({ApiResponse<UserData>? auth_State, TaskRepositoryImpl? repo})
      : _repo = repo,
        authState = auth_State;

  //todo: do some thing when user token change
  void reload() {}
}
