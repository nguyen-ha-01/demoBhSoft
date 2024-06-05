import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiademo/common/widget/bottom_nav_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/states/nav.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColor.dialog_background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<NavCubit, NavBarState>(
              builder: (ctx, state) => BottomNavItem(
                  onTap: () {
                    ctx.read<NavCubit>().go(NavBarState.Index);
                  },
                  icon: Assets.icon.icHomeNav1,
                  label: 'nav.p1'.tr(),
                  iconSelected: Assets.icon.icHomeNav1Se,
                  isSelected: state == NavBarState.Index)),
          BlocBuilder<NavCubit, NavBarState>(
            builder: (ctx, state) => BottomNavItem(
                onTap: () {
                  ctx.read<NavCubit>().go(NavBarState.Calender);
                },
                icon: Assets.icon.icHomeNav2,
                label: 'nav.p2'.tr(),
                iconSelected: Assets.icon.icHomeNav2Se,
                isSelected: state == NavBarState.Calender),
          ),
          const SizedBox(
            width: 100,
          ),
          BlocBuilder<NavCubit, NavBarState>(
            builder: (ctx, state) => BottomNavItem(
                onTap: () {
                  ctx.read<NavCubit>().go(NavBarState.Focus);
                },
                icon: Assets.icon.icHomeNav3,
                label: 'nav.p3'.tr(),
                iconSelected: Assets.icon.icHomeNav3Se,
                isSelected: state == NavBarState.Focus),
          ),
          BlocBuilder<NavCubit, NavBarState>(
            builder: (ctx, state) => BottomNavItem(
                onTap: () {
                  ctx.read<NavCubit>().go(NavBarState.Profile);
                },
                icon: Assets.icon.icHomeNav4,
                label: 'nav.p4'.tr(),
                iconSelected: Assets.icon.icHomeNav4Se,
                isSelected: state == NavBarState.Profile),
          ),
        ],
      ),
    );
  }
}
