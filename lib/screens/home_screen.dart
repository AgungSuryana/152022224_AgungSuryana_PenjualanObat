import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'news_service.dart'; // Import NewsService untuk mengambil berita
import 'news_detail_screen.dart'; // Import halaman detail berita

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
      body: SingleChildScrollView(
        // Membuat body scrollable
        child: Column(
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
            // Carousel Slider
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
            const SizedBox(height: 30),
            // Menampilkan berita di bawah carousel
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Latest News',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Menampilkan berita dengan FutureBuilder
            FutureBuilder<List<dynamic>>(
              future: NewsService()
                  .fetchNews(), // Memanggil fetchNews dari NewsService
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No news available.'));
                }

                final articles = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];

                    return ListTile(
                      leading: article['urlToImage'] != null
                          ? Image.network(
                              article['urlToImage'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image),
                      title: Text(article['title'] ?? 'No title'),
                      subtitle:
                          Text(article['description'] ?? 'No description'),
                      onTap: () {
                        // Navigasi ke halaman detail
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(
                              title: article['title'] ?? 'No title',
                              description:
                                  article['description'] ?? 'No description',
                              imageUrl: article['urlToImage'] ?? '',
                              content:
                                  article['content'] ?? 'No content available.',
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
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
