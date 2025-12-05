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

    // Warna tema
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);
    const Color accentColor = Color(0xFFF2D593);

    return Scaffold(
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
              // HEADER PROFIL
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: accentColor.withOpacity(0.2),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: accentColor,
                    ),
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

              // STATISTIK BELAJAR (masih dummy)
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
                  Expanded(
                    child: _StatCard(value: '5', label: 'Kursus Diikuti'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(value: '23', label: 'Modul Selesai'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(value: '🥇', label: 'Data Scientist'),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // MENU MANAJEMEN AKUN
              _ProfileMenuTile(
                icon: Icons.edit_outlined,
                title: 'Edit Profil',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfilePage(),
                    ),
                  );
                },
              ),
              _ProfileMenuTile(
                icon: Icons.lock_outline,
                title: 'Ubah Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChangePasswordPage(),
                    ),
                  );
                },
              ),
              _ProfileMenuTile(
                icon: Icons.info_outline,
                title: 'Tentang CodetoData',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const _AboutCodetoDataDialog(),
                  );
                },
              ),
              const SizedBox(height: 24),

              // TOMBOL LOGOUT
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.redAccent.withOpacity(0.5),
                    ),
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

// ============================================================================
// KARTU STATISTIK
// ============================================================================
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

// ============================================================================
// TILE MENU PROFIL
// ============================================================================
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
              leading: const Icon(
                Icons.circle,
                size: 0, // dummy, biar gak kedip pas change icon color
              ),
              // pakai Row supaya icon bisa custom warna
              title: Row(
                children: [
                  Icon(icon, color: const Color(0xFFF2D593)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              trailing:
              const Icon(Icons.chevron_right, color: Colors.white70),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HALAMAN EDIT PROFIL
// ============================================================================
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthService>();
    _nameController = TextEditingController(text: auth.name ?? '');
    _emailController = TextEditingController(text: auth.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final auth = context.read<AuthService>();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan email tidak boleh kosong')),
      );
      return;
    }

    await auth.updateProfile(name: name, email: email);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _save,
                  child: const Text('Simpan Perubahan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HALAMAN UBAH PASSWORD
// ============================================================================
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final oldPass = _oldPasswordController.text;
    final newPass = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (oldPass.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field wajib diisi')),
      );
      return;
    }

    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password baru tidak cocok')),
      );
      return;
    }

    setState(() => _isLoading = true);
    final auth = context.read<AuthService>();
    final success = await auth.changePassword(
      oldPassword: oldPass,
      newPassword: newPass,
    );
    setState(() => _isLoading = false);

    if (!success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password lama salah')),
      );
      return;
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berhasil diubah')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                TextField(
                  controller: _oldPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password lama',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password baru',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Konfirmasi password baru',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _isLoading ? null : _changePassword,
                  child: _isLoading
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Simpan Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// DIALOG TENTANG CODETODATA
// ============================================================================
class _AboutCodetoDataDialog extends StatelessWidget {
  const _AboutCodetoDataDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tentang CodetoData'),
      content: const Text(
        'CodetoData adalah aplikasi pembelajaran yang membantu '
            'mahasiswa dan profesional pemula mempelajari Python, R, SQL, '
            'dan data science yang relevan dengan industri e-commerce '
            'seperti Tokopedia.\n\n'
            'Fitur utama:\n'
            '• Materi terstruktur\n'
            '• Video pembelajaran\n'
            '• Quiz interaktif dengan sound\n'
            '• Integrasi dokumentasi melalui WebView',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
