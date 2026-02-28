import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _idToken;

  String? get idToken => _idToken;
  bool get isLoggedIn => _idToken != null;

  void login(String token) {
    _idToken = token;
    notifyListeners();
  }

  void logout() {
    _idToken = null;
    notifyListeners();
  }
}