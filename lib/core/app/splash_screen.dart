import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../feature/onboarding/onboarding_screen.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'News ',
              style: AppTextStyle.gt18white
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            Text(
              'App',
              style: AppTextStyle.gt18white.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: const Color(0xff98BFFF)),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.darkBlack,
      pageTransitionType: PageTransitionType.fade,
      nextScreen: const OnboardingScreen(),
      duration: 1200,
    );
  }
}
