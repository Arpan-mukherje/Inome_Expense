import 'package:animated_splash_screen/animated_splash_screen.dart'; // Import This when you will use  " AnimatedSplashScreen "
import 'package:assignment/screens/Authenticaton/signup.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 4000,
      splash: Image.asset(
        "assets/splash.png",
        fit: BoxFit.fitWidth,
      ),

      // backgroundColor: Colors.red,
      nextScreen: SignUp(),
      duration: 4000,
    );
  }
}
