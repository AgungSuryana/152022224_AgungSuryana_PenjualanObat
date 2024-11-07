import 'package:flutter/material.dart';

class DiscountCalculatorPage extends StatefulWidget {
  @override
  _DiscountCalculatorPageState createState() => _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState extends State<DiscountCalculatorPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  String _finalPrice = '';

  void _calculateDiscount() {
    double price = double.tryParse(_priceController.text) ?? 0;
    double discount = double.tryParse(_discountController.text) ?? 0;

    if (price > 0 && discount >= 0 && discount <= 100) {
      double finalPrice = price - (price * (discount / 100));
      setState(() {
        _finalPrice =
            'Harga setelah diskon: Rp${finalPrice.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _finalPrice = 'Masukkan data yang valid';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perhitungan Diskon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga Awal (Rp)'),
            ),
            TextField(
              controller: _discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Diskon (%)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateDiscount,
              child: Text('Hitung Diskon'),
            ),
            SizedBox(height: 20),
            Text(_finalPrice, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
