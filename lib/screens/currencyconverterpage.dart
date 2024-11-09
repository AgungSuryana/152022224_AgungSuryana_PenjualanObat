import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedAmount = 0.0;
  String _fromCurrency = 'USD';
  String _toCurrency = 'IDR';

  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'IDR': 15670.0, // 1 USD = 15,582 IDR
    'EUR': 0.93, // 1 USD = 0.92 EUR
    'JPY': 152.0, // 1 USD = 108 JPY
  };

  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount > 0) {
      double fromRate = _exchangeRates[_fromCurrency] ?? 1.0;
      double toRate = _exchangeRates[_toCurrency] ?? 1.0;
      setState(() {
        _convertedAmount = (amount / fromRate) * toRate;
      });
    } else {
      setState(() {
        _convertedAmount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Mata Uang')),
      body: Padding(
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
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Jumlah'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: _fromCurrency,
                          items: _exchangeRates.keys.map((String currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _fromCurrency = value!;
                            });
                          },
                        ),
                        const Icon(Icons.swap_horiz),
                        DropdownButton<String>(
                          value: _toCurrency,
                          items: _exchangeRates.keys.map((String currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _toCurrency = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _convertCurrency,
                      child: const Text('Konversi'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Hasil: ${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
                      style: const TextStyle(fontSize: 24),
                    ),
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
