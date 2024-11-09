import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'dart:math';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String result = '';

  String formatResult(double value) {
    return value == value.toInt() ? value.toInt().toString() : value.toString();
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        try {
          String evalInput = input;

          // Ganti simbol ^ dengan panggilan pow() jika ada
          evalInput = evalInput.replaceAllMapped(RegExp(r'(\d+(\.\d+)?)\^(\d+(\.\d+)?)'), (match) {
            double base = double.parse(match.group(1)!);
            double exponent = double.parse(match.group(3)!);
            return pow(base, exponent).toString();
          });

          // Tangani akar kuadrat (√)
          evalInput = evalInput.replaceAllMapped(RegExp(r'√(\d+(\.\d+)?)'), (match) {
            double number = double.parse(match.group(1)!);
            return sqrt(number).toString();
          });

          // Evaluasi ekspresi setelah penggantian simbol khusus
          const evaluator = ExpressionEvaluator();
          final expression = Expression.parse(evalInput.replaceAll('×', '*').replaceAll('÷', '/'));
          final evalResult = evaluator.eval(expression, {});

          if (evalResult is double) {
            result = formatResult(evalResult);
          } else {
            result = evalResult.toString();
          }
        } catch (e) {
          result = 'Error';
        }
      } else if (value == 'C') {
        input = '';
        result = '';
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar
    double buttonWidth = MediaQuery.of(context).size.width / 4 - 16; // Membagi lebar layar dengan 4 untuk tombol

    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator')),
      body: Column(
        children: [
          // Bagian untuk input
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                input,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          // Bagian untuk hasil
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                result,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              ),
            ),
          ),
          // Bagian untuk tombol kalkulator menggunakan Wrap
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              ...['7', '8', '9', 'C', '4', '5', '6', '÷', '1', '2', '3', '×', '0', '.', '-', '+', '√', '^']
                  .map(
                    (value) => SizedBox(
                      width: buttonWidth,
                      height: 90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF11767A),
                          disabledForegroundColor: Colors.grey.withOpacity(0.38),
                          disabledBackgroundColor: Colors.grey.withOpacity(0.12), // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 5, // Gives shadow to the button
                        ),
                        onPressed: () => _onButtonPressed(value),
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  )
                  // ignore: unnecessary_to_list_in_spreads
                  .toList(),
              // Tombol "=" dengan ukuran yang lebih proporsional
              SizedBox(
                width: buttonWidth * 2 + 10, // Lebar tombol "=" setara dengan dua tombol lainnya
                height: 90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF11767A),
                    disabledForegroundColor: Colors.grey.withOpacity(0.38),
                    disabledBackgroundColor: Colors.grey.withOpacity(0.12), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 5, // Gives shadow to the button
                  ),
                  onPressed: () => _onButtonPressed('='),
                  child: const Text(
                    '=',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
