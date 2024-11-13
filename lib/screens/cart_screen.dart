import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    int _calculateTotalPrice() {
      num totalPrice = 0;
      for (var item in widget.cartItems) {
        totalPrice += item['price'] * item['qty'];
      }
      return totalPrice.toInt(); 
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Keranjang Anda kosong'))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        widget.cartItems[index]['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      widget.cartItems[index]['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Qty: ${widget.cartItems[index]['qty']} - Total: Rp ${widget.cartItems[index]['price'] * widget.cartItems[index]['qty']}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total Harga: Rp ${_calculateTotalPrice()}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.payment,
                            color: Colors.white),
                        SizedBox(
                            width: 10),
                        Text('Melanjutkan ke pembayaran...'),
                      ],
                    ),
                    backgroundColor:
                        Colors.green,
                    duration:
                        const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'Batal', 
                      onPressed: () {
                      },
                    ),
                  ),
                );
              },
              // ignore: sort_child_properties_last
              child: const Text('Lanjutkan Pembayaran'),
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(double.infinity, 50), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
