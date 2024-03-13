import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../feature/main/store/main_store.dart';
import '../../feature/onboarding/store/onboarding_store.dart';
import 'splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => MainStore()),
        Provider(create: (_) => OnboardingStore()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
