import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/states/nav.dart';

import '../../gen/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.action, required this.url});

  final Function() action;
  final String? url;

  @override
  Widget build(BuildContext context) => BlocBuilder<NavCubit, NavBarState>(builder: (ctx, state) {
        if (state == NavBarState.Index) {
          return buildOnIndex(state.name);
        }
        return buildOnOther(state.name);
      });
  Widget buildOnOther(String title) => SafeArea(
          child: Row(
        children: [
          Expanded(
              child: Center(
            child: Text(
              title,
              style: AppTextStyle.type24,
            ),
          ))
        ],
      ));

  Widget buildOnIndex(String title) => SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 42,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: action,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      Assets.icon.icAppBar1,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: AppTextStyle.type24,
                ),
              )),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: (url != null)
                    ? CachedNetworkImage(
                        imageUrl: url!,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        Assets.icon.holder,
                        width: 42,
                        height: 42,
                      ),
              )
            ],
          ),
        ),
      );
  @override
  Size get preferredSize => const Size.fromHeight(42);
}
