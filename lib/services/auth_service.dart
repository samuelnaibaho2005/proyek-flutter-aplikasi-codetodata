// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static const _keyEmail = 'user_email';
  static const _keyPassword = 'user_password';
  static const _keyName = 'user_name';
  static const _keyLevel = 'user_level';
  static const _keyLoggedIn = 'logged_in';

  String? _name;
  String? _email;
  String? _level;
  bool _loggedIn = false;

  String? get name => _name;
  String? get email => _email;
  String? get level => _level;
  bool get isLoggedIn => _loggedIn;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool(_keyLoggedIn) ?? false;
    _name = prefs.getString(_keyName);
    _email = prefs.getString(_keyEmail);
    _level = prefs.getString(_keyLevel);
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Di sini tidak ada cek duplicate user dsb, karena hanya 1 user lokal.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
    // default level: null, nanti di-set di level selection
    return true;
  }

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

  Future<void> setLevel(String level) async {
    final prefs = await SharedPreferences.getInstance();
    _level = level;
    await prefs.setString(_keyLevel, level);
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, false);
    _loggedIn = false;
    notifyListeners();
  }
}
