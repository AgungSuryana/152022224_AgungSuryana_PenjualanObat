import 'package:flutter/material.dart';

class SplashScreen2 extends StatelessWidget {
  // ignore: use_super_parameters
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamedAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        '/', // Rute ke halaman login
        (route) => false, // Menghapus semua rute sebelumnya
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash2.png', // Replace with your image path
          width: 400, // Adjust size as needed
          height: 400, // Adjust size as needed
        ),
      ),
    );
  }
}
