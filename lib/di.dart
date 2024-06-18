import 'package:get_it/get_it.dart';
import 'package:tiademo/models/repository/task_repository_impl.dart';
import 'package:tiademo/states/add_category.dart';
import 'package:tiademo/states/cubit/nav.dart';
import 'package:tiademo/states/cubit/splash_cubit.dart';
import 'package:tiademo/states/task_provider.dart';
import 'package:tiademo/states/user_provider.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory(NavCubit.new);
  getIt.registerFactory(AddCategory.new);
  getIt.registerFactory(SplashCubit.new);

  //Singleton
  getIt.registerSingleton<UserProvider>(UserProvider.create());
  getIt.registerSingleton<TaskProvider>(TaskProvider(repo: TaskRepositoryImpl()));
}
