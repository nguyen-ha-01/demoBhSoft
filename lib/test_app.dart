import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiademo/config/system.dart';
import 'package:tiademo/core/app_theme.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/routes/route.dart';
import 'package:tiademo/states/task_provider.dart';
import 'package:tiademo/states/user_provider.dart';
import 'package:tiademo/ui/home_page/home_page.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (c) => getIt<UserProvider>()..init()),
        ChangeNotifierProxyProvider<UserProvider, TaskProvider>(
            create: (c) => TaskProvider()..init(),
            update: (context, user, task) {
              return task!..update(user.authState);
            })
      ],
      child: GetMaterialApp(
          enableLog: true,
          defaultTransition: Transition.leftToRight,
          opaqueRoute: Get.isOpaqueRouteDefault,
          popGesture: Get.isPopGestureEnable,
          getPages: Routes.pages,
          locale: System.mainLocale,
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          themeMode: ThemeMode.dark,
          //todo: change to test
          // home: DetailTaskPage(category: getCategory(), task: getTask()),
          home: const HomePage(),
          theme: AppTheme.darkAppTheme),
    );
  }
}
