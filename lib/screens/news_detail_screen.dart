import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String content;

  NewsDetailScreen({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        // Memastikan bisa scroll jika konten panjang
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (imageUrl.isNotEmpty) Image.network(imageUrl),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Tampilkan deskripsi yang sudah dibersihkan
            Text(
              cleanDescription(description),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(content), // Isi konten artikel jika ada
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membersihkan teks yang tidak diinginkan
  String cleanDescription(String description) {
    return description.replaceAll(
        RegExp(r'\[\+.*?chars\]'), ''); // Menghapus teks dalam tanda []
  }
}
