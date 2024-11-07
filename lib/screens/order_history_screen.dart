import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Pastikan path ini sesuai dengan struktur proyek

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Pesanan')),
      body: Center(child: Text('Riwayat pesanan Anda akan muncul di sini.')),
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
