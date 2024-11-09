import 'package:flutter/material.dart';

class DiscountCalculatorPage extends StatefulWidget {
  const DiscountCalculatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
            'Harga diskon: Rp${finalPrice.toStringAsFixed(2)}';
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
      appBar: AppBar(title: const Text('Perhitungan Diskon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(  // Menggunakan Column sebagai widget utama
          children: [
            const SizedBox(height: 60), // Menambahkan jarak atas
            Card(
              color: Colors.white,
              elevation: 4.0, // Menambahkan bayangan pada Card
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Harga Awal (Rp)'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Diskon (%)'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateDiscount,
                      child: const Text('Hitung Diskon'),
                    ),
                    const SizedBox(height: 20),
                    Text(_finalPrice, style: const TextStyle(fontSize: 24)),
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
