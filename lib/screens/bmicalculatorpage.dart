import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class BmiCalculatorPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BmiCalculatorPageState createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _result = '';
  String _classification = '';

  void _calculateBmi() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        _result = 'BMI Anda: ${bmi.toStringAsFixed(2)}';

        if (bmi < 18.5) {
          _classification = 'Underweight';
        } else if (bmi >= 18.5 && bmi <= 24.9) {
          _classification = 'Normal';
        } else if (bmi >= 25.0 && bmi <= 29.9) {
          _classification = 'Overweight';
        } else {
          _classification = 'Obesity';
        }
      });
    } else {
      setState(() {
        _result = 'Masukkan data yang valid';
        _classification = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60), 
              Card( 
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Berat Badan (kg)'),
                      ),
                      TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Tinggi Badan (cm)'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _calculateBmi,
                        child: const Text('Hitung BMI'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _result,
                        style: const TextStyle(fontSize: 24),
                      ),
                      if (_classification.isNotEmpty)
                        Text(
                          'Klasifikasi: $_classification',
                          style: const TextStyle(fontSize: 18),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
