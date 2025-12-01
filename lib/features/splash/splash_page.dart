// lib/features/splash/splash_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), _goNext);
  }

  void _goNext() {
    final auth = context.read<AuthService>();

    if (auth.isLoggedIn) {
      // Kalau sudah login tapi belum punya level → pilih level dulu.
      if (auth.level == null || auth.level!.isEmpty) {
        Navigator.pushReplacementNamed(context, AppRoutes.levelSelection);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF283845),
      body: Center(
        child: Image.asset(
          'assets/images/logo_app.png',
          width: 600,
        ),
      ),
    );
  }
}
