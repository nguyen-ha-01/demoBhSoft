import 'package:tiademo/models/user.dart';
import 'package:tiademo/states/state/base_state.dart';

abstract class UserRepository {
  Future<ApiResponse<UserData>> login(String username, String password);
  Future<ApiResponse<UserData>> signUp(String username, String password);
  Future<bool> changePassword(String token, String oldPassword, String newPassword);
  Future<bool> rememberLogin(UserData user);
  Future<bool> logout();
}
