import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  // Declare controllers here to retain the text
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _textColorAnimation; // Animasi untuk warna teks

  @override
  void initState() {
    super.initState();
    
    // Controller untuk animasi
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true); // Animasi berulang

    // Tween untuk animasi pergantian warna latar belakang
    _colorAnimation = ColorTween(
      begin: const Color(0xFF11767A), // Warna awal
      end: const Color.fromARGB(255, 255, 255, 255), // Warna akhir (Putih)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Tween untuk animasi pergantian warna teks
    _textColorAnimation = ColorTween(
      begin: Colors.white, // Warna awal teks
      end: const Color(0xFF11767A), // Warna akhir teks (Hijau)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose(); // Pastikan controller dibersihkan setelah widget dihancurkan
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            color: _colorAnimation.value, // Menampilkan perubahan warna latar belakang
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _textColorAnimation.value, // Menggunakan animasi warna teks
                              fontSize: 35.0,
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
                            // Use the controllers here
                            TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(labelText: 'Username'),
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration: const InputDecoration(labelText: 'Password'),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Dummy validation
                                if (true) {
                                  Navigator.pushReplacementNamed(context, '/home');
                                // ignore: dead_code
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Login gagal!')),
                                  );
                                }
                              },
                              child: const Text('Login'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Belum punya akun? Daftar di sini',
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
