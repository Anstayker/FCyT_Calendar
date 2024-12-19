import 'package:flutter/material.dart';
import 'default_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = defaultTheme();
  bool _isDarkMode = false;

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? darkTheme() : defaultTheme();
    notifyListeners();
  }
}
