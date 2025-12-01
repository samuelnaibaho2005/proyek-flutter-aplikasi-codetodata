// lib/features/auth/login_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final auth = context.read<AuthService>();

    final ok = await auth.login(
      email: _emailC.text.trim(),
      password: _passwordC.text,
    );

    setState(() => _loading = false);

    if (!mounted) return;

    if (ok) {
      if (auth.level == null || auth.level!.isEmpty) {
        Navigator.pushReplacementNamed(context, AppRoutes.levelSelection);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN 1: Definisikan Warna ---
    const Color primaryColor = Color(0xFF283845); // Biru Gelap
    const Color secondaryColor = Color(0xFF202C39); // Warna gradien kedua
    const Color accentColor = Color(0xFFF2D593);   // Emas / Krem

    return Scaffold(
      // --- PERUBAHAN 2: AppBar Transparan ---
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: accentColor, // Warna title dan ikon
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        // --- PERUBAHAN 3: Latar Belakang Gradien ---
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 0),
                Image.asset('assets/images/logo_app.png', height: 200),
                const SizedBox(height: 0),
                Text(
                  'Selamat Datang Kembali',
                  textAlign: TextAlign.center,
                  // --- PERUBAHAN 4: Style Teks Judul ---
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailC,
                  style: const TextStyle(color: Colors.white),
                  // --- PERUBAHAN 5: Style Input Form (Dark Mode) ---
                  decoration: _buildInputDecoration('Email', accentColor),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Email tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordC,
                  style: const TextStyle(color: Colors.white),
                  // --- PERUBAHAN 5: Style Input Form (Dark Mode) ---
                  decoration: _buildInputDecoration('Password', accentColor),
                  obscureText: true,
                  validator: (v) =>
                  (v == null || v.isEmpty) ? 'Password tidak boleh kosong' : null,
                ),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: _loading ? null : _onLogin,
                  // --- PERUBAHAN 6: Style Tombol Utama ---
                  style: FilledButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: primaryColor,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  )
                      : const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                  },
                  // --- PERUBAHAN 7: Style Tombol Teks ---
                  style: TextButton.styleFrom(
                    foregroundColor: accentColor,
                  ),
                  child: const Text('Belum punya akun? Daftar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- PERUBAHAN 8: Helper Method untuk Dekorasi Input (Sama seperti di Register) ---
  InputDecoration _buildInputDecoration(String label, Color accentColor) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: accentColor.withOpacity(0.7)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: accentColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: accentColor, width: 2),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}