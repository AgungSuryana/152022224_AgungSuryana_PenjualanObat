import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Pastikan path ini sesuai dengan struktur proyek

// ignore: use_key_in_widget_constructors
class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Kotak seperti AppBar dengan border radius
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            decoration: const BoxDecoration(
              color: Color(0xFF11767A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: const Center(
              child: Text(
                'Riwayat Pesanan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          // Konten tambahan
          const Expanded(
            child: Center(
              child: Text('Riwayat pesanan Anda akan muncul di sini.'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Sesuaikan dengan index halaman ini (index ke-2 untuk Riwayat)
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
