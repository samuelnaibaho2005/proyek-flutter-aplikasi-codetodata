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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Tingkat Anda'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih satu sesuai kemampuan saat ini:',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => _selectLevel(context, 'Umum'),
              child: const Text('Umum'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => _selectLevel(context, 'Mahasiswa'),
              child: const Text('Mahasiswa'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => _selectLevel(context, 'Profesional'),
              child: const Text('Profesional'),
            ),
          ],
        ),
      ),
    );
  }
}
