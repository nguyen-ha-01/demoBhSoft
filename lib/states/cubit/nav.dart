import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavBarState { Index, Calender, Focus, Profile }

class NavCubit extends Cubit<NavBarState> {
  NavCubit() : super(NavBarState.Index);
  void go(NavBarState to) {
    if (kDebugMode) {
      print(to.name);
    }
    emit(to);
  }
}
