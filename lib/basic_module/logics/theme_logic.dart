import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeLogic extends ChangeNotifier {
  final _key = "ThemeLogic";
  final _storage = const FlutterSecureStorage(); // Added const

  int _themeIndex = 0;
  int get themeIndex => _themeIndex;

  // 1. HELPER: Converts your number to a real ThemeMode
  ThemeMode get mode {
    if (_themeIndex == 1) return ThemeMode.dark;
    if (_themeIndex == 2) return ThemeMode.light;
    return ThemeMode.system; // Default (0)
  }

  Future<void> readTheme() async {
    String index = await _storage.read(key: _key) ?? "0";
    _themeIndex = int.parse(index);
    notifyListeners();
  }

  void changeToSystem() {
    _themeIndex = 0;
    _save();
  }

  void changeToDark() {
    _themeIndex = 1;
    _save();
  }

  void changeToLight() {
    _themeIndex = 2;
    _save();
  }

  // Helper to save code repetition
  void _save() {
    _storage.write(key: _key, value: _themeIndex.toString());
    notifyListeners();
  }
}