// lib/features/profile/profile_page.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    // --- PERUBAHAN 1: Definisikan Warna Tema ---
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);
    const Color accentColor = Color(0xFFF2D593);

    return Scaffold(
      // --- PERUBAHAN 2: Latar Belakang Transparan & AppBar ---
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: accentColor,
      ),
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
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              // --- PERUBAHAN 4: Header Profil ---
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: accentColor.withOpacity(0.2),
                    child: const Icon(Icons.person, size: 50, color: accentColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    auth.name ?? 'Pengguna CodetoData',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    auth.email ?? '-',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 8),
                  if (auth.level != null)
                    Chip(
                      label: Text(
                        'Level: ${auth.level}',
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                ],
              ),
              const SizedBox(height: 32),

              // --- PERUBAHAN 5: Statistik Belajar ---
              Text(
                'Statistik Belajar',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: _StatCard(value: '5', label: 'Kursus Diikuti')),
                  SizedBox(width: 12),
                  Expanded(child: _StatCard(value: '23', label: 'Modul Selesai')),
                  SizedBox(width: 12),
                  Expanded(child: _StatCard(value: '85%', label: 'Skor Quiz')),
                ],
              ),
              const SizedBox(height: 32),

              // --- PERUBAHAN 6: Menu Manajemen Akun ---
              _ProfileMenuTile(
                icon: Icons.edit_outlined,
                title: 'Edit Profil',
                onTap: () {
                  /* TODO: Navigasi ke halaman edit profil */
                },
              ),
              _ProfileMenuTile(
                icon: Icons.lock_outline,
                title: 'Ubah Password',
                onTap: () {
                  /* TODO: Navigasi ke halaman ubah password */
                },
              ),
              _ProfileMenuTile(
                icon: Icons.info_outline,
                title: 'Tentang CodetoData',
                onTap: () {
                  /* TODO: Tampilkan dialog tentang aplikasi */
                },
              ),
              _ProfileMenuTile(
                icon: Icons.star_outline,
                title: 'Beri Rating Aplikasi',
                onTap: () {
                  /* TODO: Buka Play Store/App Store */
                },
              ),
              const SizedBox(height: 24),

              // --- PERUBAHAN 7: Tombol Logout ---
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.redAccent.withOpacity(0.5)),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () async {
                  await auth.logout();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget kustom untuk kartu statistik
class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFF2D593).withOpacity(0.3),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget kustom untuk menu profil
class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              onTap: onTap,
              leading: Icon(icon, color: const Color(0xFFF2D593)),
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white70),
            ),
          ),
        ),
      ),
    );
  }
}