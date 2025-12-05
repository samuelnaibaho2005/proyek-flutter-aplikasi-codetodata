// lib/features/auth/level_selection_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/auth_service.dart';

class LevelSelectionPage extends StatelessWidget {
  const LevelSelectionPage({super.key});

  Future<void> _selectLevel(BuildContext context, String level) async {
    final auth = context.read<AuthService>();
    await auth.setLevel(level);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    const Color primaryColor = Color(0xFF283845); // Biru Gelap
    const Color secondaryColor = Color(0xFF202C39); // Warna gradien kedua
    const Color accentColor = Color(0xFFF2D593);

    return Scaffold(
      // --- PERUBAHAN 2: AppBar Transparan & Latar Belakang ---
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Pilih Latar Belakang Anda'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: accentColor,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        // --- PERUBAHAN 3: Latar Belakang Gradien ---
        width: double.infinity,
        // height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_app.png', height: 200),
                Text(
                  'Pilih latar belakang anda saat ini',
                  // --- PERUBAHAN 4: Style Teks Judul ---
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // --- PERUBAHAN 5: Style Tombol Pilihan ---
                // Tombol utama dengan gaya paling menonjol
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: primaryColor,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _selectLevel(context, 'Umum'),
                  child: const Text(
                    'Umum',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol sekunder dengan gaya outline
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: accentColor,
                    side: BorderSide(color: accentColor, width: 2),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _selectLevel(context, 'Mahasiswa'),
                  child: const Text(
                    'Mahasiswa',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol ketiga dengan gaya terbalik (background gelap)
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: accentColor,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: accentColor.withOpacity(0.5)),
                    ),
                  ),
                  onPressed: () => _selectLevel(context, 'Pekerja'),
                  child: const Text(
                    'Pekerja',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}