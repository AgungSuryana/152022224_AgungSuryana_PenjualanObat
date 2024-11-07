import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'dart:math';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String result = '';

  String formatResult(double value) {
    // Jika nilai adalah bilangan bulat, tampilkan tanpa desimal
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
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator')),
      body: Column(
        children: [
          // Bagian untuk input
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                input,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          // Bagian untuk hasil
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                result,
                style: TextStyle(fontSize: 32, color: Colors.blue),
              ),
            ),
          ),
          // Bagian grid untuk tombol kalkulator
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              ...['7', '8', '9', 'C', '4', '5', '6', '÷', '1', '2', '3', '×', '0', '.', '-', '+', '√', '^', '=']
                  .map(
                    (value) => Container(
                      margin: EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.grey[300],
                        ),
                        onPressed: () => _onButtonPressed(value),
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
