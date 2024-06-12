import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/di.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/routes/named_route.dart';
import 'package:tiademo/states/cubit/splash_cubit.dart';
import 'package:tiademo/states/state/base_cubit_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Thay đổi thời gian theo ý của bạn
    );
    _animation = Tween<double>(
      begin: 0.1, // Độ mờ ban đầu
      end: 1.0, // Độ mờ cuối cùng
    ).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (c) => getIt<SplashCubit>()..init(),
      child: BlocListener<SplashCubit, BaseCubitState<dynamic>>(
        listener: (c, s) {
          if (s.status == Status.success) {
            Get.offNamed(NamedRoutes.home_page);
          }
          if (s.status == Status.failure) {
            print(s.error);
            if (s.error?.length == 1) {
              Get.offNamed(NamedRoutes.intro_page);
            } else {
              Get.offNamed(NamedRoutes.p4);
            }
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: SvgPicture.asset(Assets.icon.icApp, width: 226, height: 226, fit: BoxFit.contain),
              ),
              Text(
                tr('commons.h1'),
                style: AppTextStyle.type24.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
