import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/ui/home_page/home_page.dart';

import 'config/system.dart';
import 'core/app_theme.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  init();
  runApp(
    EasyLocalization(
      supportedLocales: System.supportedLocales,
      path: 'assets/i18',
      fallbackLocale: System.mainLocale,
      startLocale: System.mainLocale,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: AppTheme.darkAppTheme,
      home: const HomePage(),
    );
  }
}
