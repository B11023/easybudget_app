import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final systemIsDark = brightness == Brightness.dark;

    if (_themeMode == ThemeMode.system) {
      _themeMode = systemIsDark ? ThemeMode.light : ThemeMode.dark;
    } else {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }

    notifyListeners();
  }
}