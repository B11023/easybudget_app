import 'package:easybudget_app/features/login/presentation/widgets/signin_button.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          debugPrint('正在登入，返回被攔截');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'EasyBudget',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Center(
              child: Image.asset(
                'assets/banana.png',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            const SizedBox(height: 30),
            const Text('香蕉工作室出品', style: TextStyle(fontSize: 30)),
            const Spacer(flex: 2),
            const SignInAndLoadButton(),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
