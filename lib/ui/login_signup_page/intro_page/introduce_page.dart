import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiademo/states/user_provider.dart';
import 'package:tiademo/ui/login_signup_page/intro_page/intro_1_page.dart';
import 'package:tiademo/ui/login_signup_page/intro_page/intro_2_page.dart';
import 'package:tiademo/ui/login_signup_page/intro_page/intro_3_page.dart';
import 'package:tiademo/ui/login_signup_page/intro_page/intro_4_page.dart';

class IntroducePage extends StatefulWidget {
  const IntroducePage({super.key});
  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> with SingleTickerProviderStateMixin {
  _IntroducePageState();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UserProvider>(
      builder: (_, p, __) {
        return TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: _tabController,
          children: [
            Intro_1_page(
              back: () {
                _tabController.animateTo(3);
              },
              next: () {
                _tabController.animateTo(1);
              },
            ),
            Intro_2_page(
              back: () {
                _tabController.animateTo(0);
              },
              next: () {
                _tabController.animateTo(2);
              },
            ),
            Intro_3_page(
              back: () {
                _tabController.animateTo(1);
              },
              next: () {
                _tabController.animateTo(3);
              },
            ),
            const Intro_4_page()
          ],
        );
      },
    ));
  }
}
