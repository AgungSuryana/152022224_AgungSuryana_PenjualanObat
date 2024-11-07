import 'package:flutter/material.dart';

class BmiCalculatorPage extends StatefulWidget {
  @override
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
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.white, // Ubah warna latar belakang Card
              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Berat Badan (kg)'),
                    ),
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Tinggi Badan (cm)'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateBmi,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue, // Ubah warna teks
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text('Hitung BMI'),
                    ),
                    SizedBox(height: 20),
                    Text(_result, style: TextStyle(fontSize: 24)),
                    if (_classification.isNotEmpty)
                      Text('Klasifikasi: $_classification', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.teal[50], // Ubah warna latar belakang Card
              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Classification', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Underweight: Below 18.5'),
                    Text('Normal: 18.5-24.9'),
                    Text('Overweight: 25.0-29.9'),
                    Text('Obesity: 30 and above'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
