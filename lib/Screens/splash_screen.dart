import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:menu/screens/instructions_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "SPLASH_SCREEN";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Lottie.asset('assets/lotties/food_delivery.json'),
        nextScreen:  const InstructionsScreen(),
        backgroundColor: const Color(0xffFF718E),
        disableNavigation: false,
        splashIconSize: double.infinity,
        duration: 5000,


      ),
    );
  }
}
