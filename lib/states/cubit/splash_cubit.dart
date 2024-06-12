import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/states/state/base_cubit_state.dart';
import 'package:tiademo/states/state/base_state.dart' as st;
import 'package:tiademo/states/user_provider.dart';

class SplashCubit extends Cubit<BaseCubitState<dynamic>> {
  SplashCubit() : super(BaseCubitState.init());
  Future<void> init() async {
    emit(BaseCubitState.loading());
    await Future.delayed(const Duration(milliseconds: 1000));
    var p = getIt<UserProvider>();
    var intro = await p.willIntroduce();
    var havingUserData = p.authState.status;
    print("havingdata $havingUserData");
    await Future.delayed(const Duration(milliseconds: 1000));
    if (havingUserData == st.Status.COMPLETED) {
      emit(BaseCubitState.success(havingUserData));
    } else {
      if (intro) {
        print("will intro");
        emit(BaseCubitState.failure("0"));
      } else {
        print("noot intro");
        emit(BaseCubitState.failure("01"));
      }
    }
    print("state emited");
  }
}
