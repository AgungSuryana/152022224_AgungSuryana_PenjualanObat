import 'package:flutter/material.dart';

class SuhuScreen extends StatefulWidget {
  const SuhuScreen({super.key});

  @override
  _SuhuScreenState createState() => _SuhuScreenState();
}

class _SuhuScreenState extends State<SuhuScreen> {
  final TextEditingController _inputController = TextEditingController();
  double? _convertedValue;
  String _selectedUnit = 'Celsius to Fahrenheit';

  void _convertTemperature() {
    double input = double.tryParse(_inputController.text) ?? 0;
    setState(() {
      if (_selectedUnit == 'Celsius to Fahrenheit') {
        _convertedValue = (input * 9 / 5) + 32;
      } else if (_selectedUnit == 'Fahrenheit to Celsius') {
        _convertedValue = (input - 32) * 5 / 9;
      } else if (_selectedUnit == 'Celsius to Kelvin') {
        _convertedValue = input + 273.15;
      } else if (_selectedUnit == 'Kelvin to Celsius') {
        _convertedValue = input - 273.15;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Suhu'),
        backgroundColor: const Color(0xFF11767A),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white, // Menentukan warna putih untuk Card
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Menjaga tinggi minimum Card
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Masukkan suhu',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedUnit,
                    items: const [
                      DropdownMenuItem(
                        value: 'Celsius to Fahrenheit',
                        child: Text('Celsius ke Fahrenheit'),
                      ),
                      DropdownMenuItem(
                        value: 'Fahrenheit to Celsius',
                        child: Text('Fahrenheit ke Celsius'),
                      ),
                      DropdownMenuItem(
                        value: 'Celsius to Kelvin',
                        child: Text('Celsius ke Kelvin'),
                      ),
                      DropdownMenuItem(
                        value: 'Kelvin to Celsius',
                        child: Text('Kelvin ke Celsius'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _convertTemperature,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF11767A),
                    ),
                    child: const Text('Konversi'),
                  ),
                  const SizedBox(height: 20),
                  if (_convertedValue != null)
                    Text(
                      'Hasil: ${_convertedValue!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
