import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey =
      '9336b677395d4434926f3908b5786c89'; // Ganti dengan API Key Anda

  // Fungsi untuk mengambil berita
  Future<List<dynamic>> fetchNews() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Jika response sukses, parse data JSON
      final data = json.decode(response.body);
      return data['articles']; // Ambil data artikel
    } else {
      throw Exception('Failed to load news');
    }
  }
}
