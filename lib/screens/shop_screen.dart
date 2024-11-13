import 'package:flutter/material.dart';
import 'product_detail_screen.dart'; // Import the product detail screen
import 'cart_screen.dart'; // Import the cart screen
import '../widgets/custom_bottom_navigation_bar.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<Map<String, String>> _products = [
    {
      'name': 'Obat A',
      'image': 'assets/images/obat_a.jpg',
      'description':
          'Deskripsi panjang Obat A yang sangat rinci sehingga membutuhkan pemotongan teks.',
      'price': 'Rp 50.000',
    },
    {
      'name': 'Obat B',
      'image': 'assets/images/obat_b.jpg',
      'description': 'Deskripsi Obat B.',
      'price': 'Rp 75.000',
    },
    {
      'name': 'Obat C',
      'image': 'assets/images/obat_c.jpg',
      'description': 'Deskripsi singkat Obat C.',
      'price': 'Rp 100.000',
    },
  ];

  final List<Map<String, dynamic>> _cartItems = [];
  String _searchQuery = '';

  // Fungsi untuk menambah produk ke keranjang
  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingItemIndex = _cartItems.indexWhere(
        (item) => item['name'] == product['name'],
      );

      if (existingItemIndex != -1) {
        _cartItems[existingItemIndex]['qty'] += 1;
      } else {
        _cartItems.add({
          'name': product['name'],
          'image': product['image'],
          'description': product['description'],
          'price':
              int.parse(product['price']!.replaceAll(RegExp(r'[^0-9]'), '')),
          'qty': 1,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['name']} ditambahkan ke keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _filteredProducts = _products
        .where((product) =>
            product['name']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 60.0, left: 16.0, right: 17.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Cari Produk',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartScreen(cartItems: _cartItems),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          onAddToCart: _addToCart,
                          product: _filteredProducts[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          child: Image.asset(
                            _filteredProducts[index]['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 120.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _filteredProducts[index]['name']!,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _filteredProducts[index]['description']!,
                              maxLines: 4, // Limit description to two lines
                              overflow: TextOverflow
                                  .ellipsis, // Ellipsis for overflow
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _filteredProducts[index]['price']!,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/shop');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/history');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/calculator');
          }
        },
      ),
    );
  }
}
