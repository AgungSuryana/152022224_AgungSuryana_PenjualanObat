import 'package:flutter/material.dart';

class SplashScreen1 extends StatelessWidget {
  // ignore: use_super_parameters
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/splash2');
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash1.png', // Replace with your image path
          width: 350, // Adjust size as needed
          height: 350, // Adjust size as needed
        ),
      ),
    );
  }
}
