import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/order_history_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/calculator_screen.dart';
import 'widgets/splash_screen2.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Penjualan Obat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: _createMaterialColor(const Color(0xFF11767A)),
        hintColor: const Color(0xFFFFA500),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF11767A),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF11767A),
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF11767A),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xFF11767A)), // Sesuaikan dengan warna tema Anda
          ),
          labelStyle: TextStyle(
            color: Color(0xFF11767A), // Sesuaikan dengan warna tema Anda
          ),
        ),
      ),
      initialRoute: '/splash2',
      routes: {
        '/splash2': (context) => const SplashScreen2(),
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/shop': (context) => ShopScreen(),
        '/history': (context) => OrderHistoryScreen(),
        '/calculator': (context) => const CalculatorScreen(),
      },
    );
  }

  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = [
      0.05,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9
    ];
    Map<int, Color> swatch = {};

    // ignore: avoid_function_literals_in_foreach_calls
    strengths.forEach((strength) {
      final ds = (strength * 255).round();
      // Pastikan nilai RGB tetap berada dalam rentang yang valid (0-255)
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        (color.red + ds).clamp(0, 255),
        (color.green + ds).clamp(0, 255),
        (color.blue + ds).clamp(0, 255),
        1,
      );
    });

    return MaterialColor(color.value, swatch);
  }
}
