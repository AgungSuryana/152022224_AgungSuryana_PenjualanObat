import 'package:flutter/material.dart';
import 'calculatorpage.dart';
import 'bmicalculatorpage.dart';
import 'currencyconverterpage.dart';
import 'discountcalculatorpage.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Kotak seperti AppBar dengan border radius
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            decoration: const BoxDecoration(
              color: Color(0xFF11767A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: const Center(
              child: Text(
                'Gungs Pharmacy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: [
                _buildCardTile(
                  context,
                  'Kalkulator',
                  Icons.calculate,
                  const CalculatorPage(),
                ),
                _buildCardTile(
                  context,
                  'BMI kalkulator',
                  Icons.fitness_center,
                  BmiCalculatorPage(),
                ),
                _buildCardTile(
                  context,
                  'Konversi Mata Uang',
                  Icons.attach_money,
                  const CurrencyConverterPage(),
                ),
                _buildCardTile(
                  context,
                  'Perhitungan Diskon',
                  Icons.percent,
                  const DiscountCalculatorPage(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
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

  Widget _buildCardTile(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      color: const Color(0xFF11767A),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
