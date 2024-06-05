import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiademo/common/widget/appbar.dart';
import 'package:tiademo/common/widget/bottom_nav.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/states/nav.dart';
import 'package:tiademo/ui/calender_page/calender_page.dart';
import 'package:tiademo/ui/focus_page/focus_page.dart';
import 'package:tiademo/ui/index_page/index_page.dart';
import 'package:tiademo/ui/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavCubit>(
      create: (BuildContext ctx) => getIt<NavCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          action: () {},
          url: null,
        ),
        body: BlocBuilder<NavCubit, NavBarState>(
          builder: (context, state) {
            return IndexedStack(
              index: NavBarState.values.indexOf(state),
              children: const [IndexPage(), CalenderPage(), FocusPage(), ProfilePage()],
            );
          },
        ),
        bottomNavigationBar: const BottomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed: () {}, child: SvgPicture.asset(Assets.icon.icHomeNav5)),
      ),
    );
  }
}
