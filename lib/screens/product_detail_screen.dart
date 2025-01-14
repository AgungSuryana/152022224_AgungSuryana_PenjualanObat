import 'package:flutter/material.dart';
import 'cart_screen.dart'; // Pastikan Anda sudah mengimpor CartScreen yang sudah diimpor
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Package untuk menampilkan rating

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product; // Update type to dynamic to handle multiple types
  final Function(Map<String, dynamic>) onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  double _rating = 4.0; // Rating awal contoh

  void _addItemToCart() {
    // Calling onAddToCart passed from ShopScreen to add product to cart
    widget.onAddToCart(widget.product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product['name']} ditambahkan ke keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image Header
          Image.network(
            widget.product['image'], // Use Image.network if it's a URL
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Back Button
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
          // Cart Button
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
                  // Navigate to the CartScreen with actual cartItems
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                          cartItems: []), // Pass actual cartItems here
                    ),
                  );
                },
              ),
            ),
          ),
          // Product Info and UI
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 350),
                // Product Name
                Text(
                  widget.product['name'] ?? 'Nama Produk Tidak Tersedia',
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Rating
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
                // Description
                Text(
                  widget.product['description'] ?? 'Deskripsi tidak tersedia.',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20),
                // Price
                Text(
                  'Rp ${widget.product['price']}',
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
      // Add to Cart Button
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
