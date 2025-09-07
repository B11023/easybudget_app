// lib/features/auth/presentation/widgets/sign_in_and_load_button.dart
import 'dart:convert';
import 'dart:developer';
import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:easybudget_app/core/auth/google_auth.dart';
import 'package:easybudget_app/core/network/api_client.dart';

class SignInAndLoadButton extends StatefulWidget {
  const SignInAndLoadButton({
    super.key,
    this.labelWhenIdle = 'Google 登入',
    this.labelWhenBusy = '處理中…',
  });

  final String labelWhenIdle;
  final String labelWhenBusy;

  @override
  State<SignInAndLoadButton> createState() => _SignInAndLoadButtonState();
}

class _SignInAndLoadButtonState extends State<SignInAndLoadButton> {
  bool _busy = false;

  Future<void> _run() async {
    final navigator = Navigator.of(context);
    if (_busy) return;
    setState(() => _busy = true);

    try {
      final idToken = await GoogleAuth.signInAndGetIdToken();
      if (!mounted) return;

      if (idToken == null || idToken.isEmpty) {
        debugPrint('使用者取消或未取得 idToken');
        return;
      }

      ApiClient.setBearer(idToken);
      final entries = await ApiClient.fetchEntries(); // List<dynamic>
      final pretty = const JsonEncoder.withIndent('  ').convert(entries);
      log(pretty);
      navigator.pushReplacementNamed("/");
    } catch (e) {
      if (!mounted) return;
      debugPrint('錯誤：$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _busy ? null : _run,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.main,
        foregroundColor: AppColors.invist,
      ),
      child: Text(
        _busy ? widget.labelWhenBusy : widget.labelWhenIdle,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
