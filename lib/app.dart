import 'package:easybudget_app/features/analyze/presentation/analyze_page.dart';
import 'package:easybudget_app/features/balance/presentation/balance_page.dart';
import 'package:easybudget_app/features/home/presentation/home_page.dart';
import 'package:easybudget_app/features/login/presentation/login_page.dart';
import 'package:easybudget_app/features/set/presentation/set_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
       }
    );
  }
}