import 'package:flutter/material.dart';
import 'cart_screen.dart'; // Pastikan Anda memiliki CartScreen yang sudah diimpor
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Package untuk menampilkan rating

class ProductDetailScreen extends StatefulWidget {
  final Map<String, String> product;
  final Function(Map<String, dynamic>) onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final List<Map<String, dynamic>> _cartItems = [];
  double _rating = 4.0; // Rating awal contoh

  void _addItemToCart() {
    setState(() {
      final existingItemIndex = _cartItems.indexWhere(
        (item) => item['name'] == widget.product['name'],
      );

      if (existingItemIndex != -1) {
        _cartItems[existingItemIndex]['qty'] += 1;
      } else {
        _cartItems.add({
          'name': widget.product['name']!,
          'image': widget.product['image']!,
          'description': widget.product['description']!,
          'price': int.parse(widget.product['price']!.replaceAll(RegExp(r'[^0-9]'), '')),
          'qty': 1,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product['name']} ditambahkan ke keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            widget.product['image']!,
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 40.0,
            left: 16.0,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            right: 16.0,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: _cartItems),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 350),
                Text(
                  widget.product['name']!,
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product['description']!,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20),
                Text(
                  ' ${widget.product['price']}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _addItemToCart,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            textStyle: const TextStyle(fontSize: 18.0),
          ),
          child: const Text('Tambah ke Keranjang'),
        ),
      ),
    );
  }
}
