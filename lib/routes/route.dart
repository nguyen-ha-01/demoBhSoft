import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiademo/common/widget/pages/error_page.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/routes/named_route.dart';
import 'package:tiademo/ui/detail_task_page/detail_task_page.dart';
import 'package:tiademo/ui/home_page/home_page.dart';
import 'package:tiademo/ui/login_signup_page/intro_page/intro_4_page.dart';
import 'package:tiademo/ui/login_signup_page/intro_page/introduce_page.dart';
import 'package:tiademo/ui/login_signup_page/login_page/login_page.dart';
import 'package:tiademo/ui/login_signup_page/signup_page/signup_page.dart';
import 'package:tiademo/ui/new_category_page/new_category_page.dart';
import 'package:tiademo/ui/splash_page/splash_page.dart';

class Routes {
  static final List<GetPage> pages = [
    _cusPage(NamedRoutes.home_page, () => const HomePage()),
    _cusPage(
        NamedRoutes.detail_task_page,
        () => Builder(builder: (c) {
              final Map<String, dynamic> data = Get.parameters;
              try {
                Task? t = data['task'];
                Category? c = data['category'];
                if (t != null && c != null) {
                  return DetailTaskPage(task: t, category: c);
                } else {
                  throw Exception("task and category was not passing");
                }
              } on Exception catch (_, e) {
                return const ErrorPage();
              }
            })),
    _cusPage(NamedRoutes.new_category_page, () => NewCategoryPage()),
    _cusPage(NamedRoutes.splash_page, () => const Scaffold(body: SplashPage())),
    _cusPage(NamedRoutes.login_page, () => const LoginPage()),
    _cusPage(NamedRoutes.signup_page, () => const SignupPage()),
    _cusPage(NamedRoutes.intro_page, () => const IntroducePage()),
    _cusPage(NamedRoutes.p4, () => const Scaffold(body: Intro_4_page()))
  ];

  static GetPage _cusPage(String route, Widget Function() page, {Map<String, dynamic>? arg}) {
    return GetPage(
      name: route,
      page: page,
      transition: Transition.leftToRight,
      arguments: arg,
    );
  }
}
