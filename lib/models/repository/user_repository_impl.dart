import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiademo/models/repository/abstract/user_repository.dart';
import 'package:tiademo/models/user.dart';
import 'package:tiademo/service/share_pref/share_preference_manage.dart';
import 'package:tiademo/states/state/base_state.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  final SharePreferenceManage sharePreferenceManage = SharePreferenceManage();

  @override
  Future<bool> changePassword(String token, String oldPassword, String newPassword) async {
    return true;
  }

  @override
  Future<ApiResponse<UserData>> login(String username, String password) async {
    // TODO: implement login
    try {
      _auth.signOut();
      var credential = await _auth.signInWithEmailAndPassword(email: username, password: password);
      var uid = credential.user?.uid;
      if (uid != null) {
        print('login____________with${uid}');
        var data = UserData(username: username, token: uid, password: password);
        sharePreferenceManage.setRememberLogin(data, true);
        return ApiResponse.completed(data);
      }
    } on FirebaseAuthException catch (e) {
      return ApiResponse.error(e.message);
    }
    return ApiResponse.loading("trouble");
  }

  @override
  Future<bool> rememberLogin(UserData user) async {
    sharePreferenceManage.setRememberLogin(user, true);
    return true;
  }

  Future<bool> checkRegistered(String username) async {
    try {
      _auth.signOut();
      await _auth.signInWithEmailAndPassword(email: username, password: "password");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return true;
      }
      print("check aregister code:${e.code}");
    }
    return false;
  }

  @override
  Future<ApiResponse<UserData>> signUp(String username, String password) async {
    try {
      // var check = await checkRegistered(username);
      // if (check) {
      _auth.signOut();
      return await _auth.createUserWithEmailAndPassword(email: username, password: password).then((value) async {
        var uid = value.user!.uid;
        if (uid != null) {
          var data = UserData(username: username, token: uid, password: password);
          print('sign up complite----------------------with${uid}');
          await rememberLogin(data);
          return ApiResponse.completed(data);
        }
        return ApiResponse.error("signup_uid_null");
      });
      // }
      print('regiter in sign in-----------------------');
    } on FirebaseAuthException catch (e) {
      return ApiResponse.error(e.code);
    }
    return ApiResponse.loading('message-------------------------sign_up-fail');
  }

  @override
  Future<bool> logout() async {
    sharePreferenceManage.setRememberLogin(null, false);
    _auth.signOut();
    return true;
  }
}
