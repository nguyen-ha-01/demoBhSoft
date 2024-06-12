import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiademo/models/user.dart';

class SharePreferenceManage {
  final storage = const FlutterSecureStorage();
  // Obtain shared preferences.
  late SharedPreferences prefs;
  final Map<String, dynamic> allData = {};
  final String willIntroduce = "WILL_INTRODUCE";
  final String rememberAccount = "REMEMBER";
  final String data = "DATA";
  //must call on create
  Future<void> setupData() async {
    var data = await storage.readAll();
    allData.addAll(data);
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> isFirstTime() async {
    var r = prefs.getBool(willIntroduce);
    if (r == null) {
      print("isfirstime");
      await prefs.setBool(willIntroduce, true);
      return true;
    } else
      print(r);
    return false;
  }

  Future<bool> isRememberLogin() async {
    return prefs.getBool(rememberAccount) ?? false;
  }

  Future<void> setRememberLogin(UserData? data, bool status) async {
    if (status) {
      prefs.setBool(rememberAccount, status);
      prefs.setString(this.data, data!.toMap().toString());
    } else {
      prefs.setBool(rememberAccount, status);
      prefs.remove(this.data);
    }
  }

  Future<UserData?> getUser() async {
    return (await isRememberLogin()) ? UserData.fromMap(jsonDecode(prefs.getString(rememberAccount) ?? "")) : null;
  }
}
