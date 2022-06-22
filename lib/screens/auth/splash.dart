import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/screens/auth/welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/lottie/loading.json'), 
      nextScreen: const WelcomeScreen(),
      backgroundColor:Colors.brown,
      splashIconSize: 250,
      duration:3000,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      );
  }
}

// LoginScreen