import 'package:easybudget_app/common/provider/auth_provider.dart';
import 'package:easybudget_app/main_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easybudget_app/common/provider/theme_provider.dart';
import 'package:easybudget_app/common/theme/app_theme.dart';
import 'package:easybudget_app/features/login/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode(),
      darkTheme: darkMode(),
      themeMode: themeProvider.themeMode,
      home: authProvider.isLoggedIn ? const MainTabPage() : const LogInPage(),
    );
  }
}
