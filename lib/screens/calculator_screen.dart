import 'package:flutter/material.dart';
import 'calculatorpage.dart';
import 'bmicalculatorpage.dart';
import 'currencyconverterpage.dart';
import 'discountcalculatorpage.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perhitungan')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildCalculatorTile(
              context,
              'Kalkulator',
              Icons.calculate,
              CalculatorPage(),
            ),
            _buildCalculatorTile(
              context,
              'BMI Calculator',
              Icons.fitness_center,
              BmiCalculatorPage(),
            ),
            _buildCalculatorTile(
              context,
              'Konversi Mata Uang',
              Icons.attach_money,
              CurrencyConverterPage(),
            ),
            _buildCalculatorTile(
              context,
              'Perhitungan Diskon',
              Icons.percent,
              DiscountCalculatorPage(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // Indeks ini sesuai dengan posisi halaman Perhitungan
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/shop');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/history');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/calculator');
          }
        },
      ),
    );
  }

  Widget _buildCalculatorTile(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: const Color(0xFF11767a),
      child: ListTile(
        leading: Icon(
          icon,
          size: 36,
          color: const Color.fromARGB(
              255, 255, 255, 255),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255), 
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
