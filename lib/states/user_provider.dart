import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiademo/models/repository/user_repository_impl.dart';
import 'package:tiademo/models/user.dart';
import 'package:tiademo/service/share_pref/share_preference_manage.dart';
import 'package:tiademo/states/state/base_state.dart';

class UserProvider extends ChangeNotifier {
  final UserRepositoryImpl _repository;
  final SharePreferenceManage _sharePreferenceManage = SharePreferenceManage();

  ApiResponse<UserData> authState = ApiResponse.init("no account yet");

  UserProvider({required UserRepositoryImpl repo}) : _repository = repo;

  factory UserProvider.create() {
    return UserProvider(repo: UserRepositoryImpl());
  }
  Future<bool> init() async {
    _sharePreferenceManage.setupData();
    var loggedUser = await _sharePreferenceManage.getUser();
    if (loggedUser != null) {
      authState = ApiResponse.completed(loggedUser);
      notifyListeners();
      print(authState.status.toString() + "loggeduser_---------------------------------init--userProvider");
      return true;
    }
    return false;
  }

  Future<bool> willIntroduce() async {
    _sharePreferenceManage.prefs = await SharedPreferences.getInstance();
    return await _sharePreferenceManage.isFirstTime();
  }

  Future<bool> login(String username, String password) async {
    var data = await _repository.login(username, password);
    if (data != null) {
      authState = data;
      if (data.status == Status.COMPLETED) {
        _sharePreferenceManage.setRememberLogin(data.data, true);
      }

      notifyListeners();
    }
    print(authState.toString());
    return false;
  }

  Future<void> register(String username, String password) async {
    try {
      authState = ApiResponse.loading("loading");
      notifyListeners();
      var data = await _repository.signUp(username, password);
      if (data != null) {
        if (data.status == Status.COMPLETED) {
          _sharePreferenceManage.setRememberLogin(data.data, true);
        }
        authState = data;
        notifyListeners();
      }
      print(authState.toString() + "---------------------------auth state--provider");
    } on Exception catch (e) {
      e.printInfo();
    }
  }

  void registerGoogle() {}

  void registerAppple() {}
}
