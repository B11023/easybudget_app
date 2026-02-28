import 'package:easybudget_app/common/provider/auth_provider.dart';
import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:easybudget_app/core/auth/google_auth.dart';
import 'package:easybudget_app/core/network/api_client.dart';
import 'package:provider/provider.dart';

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
  String? _error;

  Future<void> _run() async {
    final entryProvider = context.read<EntryProvider>();

    if (_busy) return;

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      final idToken = await GoogleAuth.signInAndGetIdToken();

      if (!mounted) return;

      if (idToken == null || idToken.isEmpty) {
        setState(() => _error = '使用者取消或未取得登入憑證');
        return;
      }
      ApiClient.setBearer(idToken);
      if (!mounted) return;
      await entryProvider.loadEntries();
      if (!mounted) return;
      context.read<AuthProvider>().login(idToken);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = '登入失敗：$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _busy ? null : _run,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
          child: Text(
            _busy ? widget.labelWhenBusy : widget.labelWhenIdle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(
            _error!,
            style: const TextStyle(color: Colors.red, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ]
      ],
    );
  }
}
