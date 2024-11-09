import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
    'assets/image4.jpg',
    'assets/image5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Kotak seperti AppBar dengan border radius
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
                20.0, 50.0, 20.0, 20.0), // Menambahkan jarak atas dengan 50.0
            decoration: const BoxDecoration(
              color: Color(0xFF11767A), // Warna latar belakang kotak
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),

            child: const Center(
              child: Text(
                'Gungs Pharmacy',
                style: TextStyle(
                  color: Colors.white, // Warna teks
                  fontSize: 30, // Ukuran teks
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          CarouselSlider(
            items: imagePaths.map((path) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Mengisi seluruh lebar layar
                    margin: const EdgeInsets.symmetric(horizontal: 7.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
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
