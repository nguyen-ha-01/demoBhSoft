import 'package:get_it/get_it.dart';
import 'package:tiademo/states/nav.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory(NavCubit.new);
}
