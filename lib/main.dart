import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiademo/config/firebaseOptions.dart';
import 'package:tiademo/core/app_theme.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/routes/route.dart';
import 'package:tiademo/states/task_provider.dart';
import 'package:tiademo/states/user_provider.dart';
import 'package:tiademo/test_app.dart';
import 'package:tiademo/ui/splash_page/splash_page.dart';

import 'config/system.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseConfig.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await init();
  runApp(
    EasyLocalization(
      supportedLocales: System.supportedLocales,
      path: 'assets/i18',
      fallbackLocale: System.mainLocale,
      startLocale: System.mainLocale,
      child: const TestApp(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (c) => getIt<UserProvider>()..init()),
        ChangeNotifierProxyProvider<UserProvider, TaskProvider>(
            create: (c) => getIt<TaskProvider>()..init(),
            update: (context, user, task) {
              return getIt<TaskProvider>()..update(user.authState);
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
          home: const SplashPage(),
          theme: AppTheme.darkAppTheme),
    );
  }
}
