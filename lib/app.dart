import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/theme/app_theme.dart';
import 'package:easybudget_app/features/analyze/presentation/analyze_page.dart';
import 'package:easybudget_app/features/balance/balance_page.dart';
import 'package:easybudget_app/features/home/home_page.dart';
import 'package:easybudget_app/features/login/login_page.dart';
import 'package:easybudget_app/features/set/set_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EntryProvider>();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode(),
        darkTheme: darkMode(),
        themeMode: provider.themeMode,
        initialRoute: '/login',
        onGenerateRoute: (RouteSettings settings) {
          late Widget page;
          switch (settings.name) {
            case '/':
              page = const HomePage();
              break;
            case '/balance':
              page = const BalancePage();
              break;
            case '/analyze':
              page = const AnalyzePage();
              break;
            case '/setting':
              page = const SetPage();
              break;
            case '/login':
              page = const LogInPage();
              break;
            default:
              page = const HomePage();
          }

          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => page,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          );
        });
  }
}
