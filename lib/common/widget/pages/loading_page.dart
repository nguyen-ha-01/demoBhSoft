import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tiademo/gen/assets.gen.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(Assets.anim.aniLoading, frameRate: const FrameRate(24), repeat: true));
  }
}
