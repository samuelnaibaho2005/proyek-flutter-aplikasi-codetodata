// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// AuthService
/// ----------------------------------------------
/// - Menyimpan data user (nama, email, level, status login)
/// - Menyimpan & mengambil data dari SharedPreferences
/// - Mengurus:
///   • register
///   • login
///   • logout
///   • pilih level
///   • edit profil
///   • ubah password
///
/// NOTE: Ini untuk keperluan tugas / demo,
/// password masih disimpan di SharedPreferences (belum di-hash).

class AuthService extends ChangeNotifier {
  // KEY untuk SharedPreferences
  static const _keyEmail = 'user_email';
  static const _keyPassword = 'user_password';
  static const _keyName = 'user_name';
  static const _keyLevel = 'user_level';
  static const _keyLoggedIn = 'logged_in';

  // STATE di memori
  String? _name;
  String? _email;
  String? _level;
  bool _loggedIn = false;

  // Getter untuk diakses dari UI
  String? get name => _name;
  String? get email => _email;
  String? get level => _level;
  bool get isLoggedIn => _loggedIn;

  /// Dipanggil sekali di main.dart:
  /// AuthService()..loadSession()
  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    _loggedIn = prefs.getBool(_keyLoggedIn) ?? false;
    _name = prefs.getString(_keyName);
    _email = prefs.getString(_keyEmail);
    _level = prefs.getString(_keyLevel);

    notifyListeners();
  }

  /// Register user baru (tanpa backend / database)
  /// Menyimpan nama, email, password ke SharedPreferences.
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);

    // Level belum di-set di sini (akan dipilih di halaman level selection)
    return true;
  }

  /// Login.
  /// Membandingkan email & password input dengan yang ada di SharedPreferences.
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_keyEmail);
    final savedPassword = prefs.getString(_keyPassword);

    if (savedEmail == email && savedPassword == password) {
      _loggedIn = true;
      _name = prefs.getString(_keyName);
      _email = savedEmail;
      _level = prefs.getString(_keyLevel);
      await prefs.setBool(_keyLoggedIn, true);

      notifyListeners();
      return true;
    }

    return false;
  }

  /// Set level belajar (Umum / Mahasiswa / Profesional).
  Future<void> setLevel(String level) async {
    final prefs = await SharedPreferences.getInstance();
    _level = level;
    await prefs.setString(_keyLevel, level);
    notifyListeners();
  }

  /// Update profil (nama & email).
  /// Dipakai di EditProfilePage.
  Future<void> updateProfile({
    String? name,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (name != null && name.isNotEmpty) {
      _name = name;
      await prefs.setString(_keyName, name);
    }

    if (email != null && email.isNotEmpty) {
      _email = email;
      await prefs.setString(_keyEmail, email);
    }

    notifyListeners();
  }

  /// Ubah password.
  /// Mengembalikan true jika password lama cocok.
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedPassword = prefs.getString(_keyPassword);

    if (savedPassword == null || savedPassword != oldPassword) {
      // password lama salah
      return false;
    }

    await prefs.setString(_keyPassword, newPassword);
    return true;
  }

  /// Logout user.
  /// Hanya mengubah status logged_in, data nama/email/level tetap tersimpan.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, false);

    _loggedIn = false;
    notifyListeners();
  }

  /// (Opsional) Reset total – jika nanti kamu mau fitur "hapus semua data".
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _name = null;
    _email = null;
    _level = null;
    _loggedIn = false;

    notifyListeners();
  }
}
