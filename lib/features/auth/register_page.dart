// lib/features/auth/register_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _confirmC = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _passwordC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final auth = context.read<AuthService>();

    await auth.register(
      name: _nameC.text.trim(),
      email: _emailC.text.trim(),
      password: _passwordC.text,
    );

    setState(() => _loading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi berhasil, silakan login')),
    );
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN 1: Definisikan Warna ---
    const Color primaryColor = Color(0xFF283845); // Biru Gelap
    // Warna kedua untuk gradien agar lebih smooth
    const Color secondaryColor = Color(0xFF202C39);
    const Color accentColor = Color(0xFFF2D593);   // Emas / Krem

    return Scaffold(
      // --- PERUBAHAN 2: AppBar Transparan ---
      // Kita buat AppBar transparan agar gradien di body terlihat menyatu
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Registrasi'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: accentColor, // Mengubah warna title dan back arrow
      ),
      // Mencegah AppBar mendorong body ke bawah saat keyboard muncul
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
          // Menggunakan SafeArea agar form tidak tertimpa status bar
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                Image.asset('assets/images/logo_app.png', height: 200),
                const SizedBox(height: 0),
                Text(
                  'Buat Akun CodetoData',
                  textAlign: TextAlign.center,
                  // --- PERUBAHAN 4: Style Teks Judul ---
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameC,
                  style: const TextStyle(color: Colors.white), // Warna teks inputan
                  // --- PERUBAHAN 5: Style Input Form (Dark Mode) ---
                  decoration: _buildInputDecoration('Nama lengkap', accentColor),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailC,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Email', accentColor),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!v.contains('@')) return 'Format email tidak valid';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordC,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Password', accentColor),
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password tidak boleh kosong';
                    if (v.length < 6) return 'Minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmC,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Konfirmasi password', accentColor),
                  obscureText: true,
                  validator: (v) {
                    if (v != _passwordC.text) {
                      return 'Password tidak sama';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: _loading ? null : _onSubmit,
                  // --- PERUBAHAN 6: Style Tombol Utama ---
                  style: FilledButton.styleFrom(
                    backgroundColor: accentColor, // Background Emas
                    foregroundColor: primaryColor, // Teks Biru Gelap
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
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  // --- PERUBAHAN 7: Style Tombol Teks ---
                  style: TextButton.styleFrom(
                    foregroundColor: accentColor,
                  ),
                  child: const Text('Sudah punya akun? Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- PERUBAHAN 8: Helper Method untuk Dekorasi Input ---
  // Dibuat agar kode tidak berulang (DRY Principle)
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
