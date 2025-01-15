import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // Pastikan menambahkan dependency http

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _textColorAnimation;

  @override
  void initState() {
    super.initState();

    // Controller untuk animasi
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    // Tween untuk animasi pergantian warna latar belakang
    _colorAnimation = ColorTween(
      begin: const Color(0xFF11767A),
      end: const Color.fromARGB(255, 255, 255, 255),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Tween untuk animasi pergantian warna teks
    _textColorAnimation = ColorTween(
      begin: Colors.white, // Warna awal teks
      end: const Color(0xFF11767A),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fungsi untuk mengirim data registrasi ke backend
  Future<void> registerUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(
          'http://10.0.2.2:3000/register'), // Ganti dengan URL backend Anda
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'role': 'user', // Tambahkan role otomatis sebagai 'user'
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil!')),
      );
      Navigator.pop(
          context); // Pindah ke halaman login setelah pendaftaran berhasil
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran gagal!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            color: _colorAnimation.value,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: _textColorAnimation.value,
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              obscureText: true,
                            ),
                            TextField(
                              controller: _confirmPasswordController,
                              decoration: const InputDecoration(
                                  labelText: 'Konfirmasi Password'),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_passwordController.text ==
                                        _confirmPasswordController.text &&
                                    _passwordController.text.isNotEmpty) {
                                  // Proses pendaftaran ke API
                                  registerUser(
                                    _usernameController.text,
                                    _passwordController.text,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Password tidak cocok atau kosong!')),
                                  );
                                }
                              },
                              child: const Text('Daftar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/');
                              },
                              child: Text(
                                'Sudah punya akun? Masuk',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: const Color(0xFF11767A)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
