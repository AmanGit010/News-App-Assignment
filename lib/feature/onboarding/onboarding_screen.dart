// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../main/main_screen.dart';
import 'store/onboarding_store.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const _BottomSheet(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                // 'assets/png/art.jpg',
                'assets/png/art1.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Bottom sheet widget

class _BottomSheet extends StatelessWidget {
  const _BottomSheet();

  @override
  Widget build(BuildContext context) {
    final store = context.read<OnboardingStore>();
    return Container(
      // height: 480,
      height: MediaQuery.sizeOf(context).height * 0.53,
      decoration: const BoxDecoration(
        color: AppColors.darkBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  'assets/svg/minus.svg',
                  color: AppColors.white,
                  height: 4,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Stay Informed Anywhere,\nAnytime.",
                textAlign: TextAlign.center,
                style: AppTextStyle.gt18white.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Access NewsApp on your smartphone, tablet, or computer. Get breaking news alerts wherever you are.",
                textAlign: TextAlign.center,
                style: AppTextStyle.gt18white.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                "Dive into the world of news with NewsApp. Start exploring and stay informed.",
                textAlign: TextAlign.center,
                style: AppTextStyle.gt18white.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    backgroundColor: AppColors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    store.googleSignIn(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/png/google_icon.png',
                        height: 26,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Login with Google",
                        style: AppTextStyle.gt18white.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false);
                },
                child: Text(
                  "Skip",
                  style: AppTextStyle.inter18white.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.purple),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
