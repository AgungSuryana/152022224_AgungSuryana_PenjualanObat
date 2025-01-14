import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    num total = 0;
    for (var item in cartItems) {
      // Mengkonversi hasil perkalian menjadi int
      total += (item['price'] * item['qty']).toInt();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Keranjang kosong. Tambahkan produk ke keranjang!'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: ListTile(
                    leading: Image.network(item['image']!, width: 50.0, height: 50.0, fit: BoxFit.cover),
                    title: Text(item['name']!),
                    subtitle: Text('Qty: ${item['qty']}'),
                    trailing: Text('Rp ${(item['price'] * item['qty']).toInt()}'), // Konversi hasil ke int
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: Rp $total',
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implementasikan logika pembayaran atau tindakan lainnya
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Fitur checkout belum tersedia')),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
    );
  }
}
