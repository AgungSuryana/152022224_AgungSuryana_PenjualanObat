import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedAmount = 0;
  final double _exchangeRate = 15582; // Contoh nilai tukar 1 USD = 15.000 IDR

  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      _convertedAmount = amount * _exchangeRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konversi Mata Uang')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah dalam USD'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Konversi ke IDR'),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil: $_convertedAmount IDR',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
