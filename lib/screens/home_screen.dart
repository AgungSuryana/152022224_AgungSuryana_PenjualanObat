import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Home')),
      body: Center(child: Text('Selamat Datang di Aplikasi Penjualan Obat')),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0, // Sesuaikan dengan index halaman saat ini
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
