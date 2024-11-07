import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/order_history_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/calculator_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Penjualan Obat',
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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/shop': (context) => ShopScreen(),
        '/history': (context) => OrderHistoryScreen(),
        '/calculator': (context) => CalculatorScreen(),
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
