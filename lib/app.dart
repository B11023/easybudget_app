import 'package:easybudget_app/features/analyze/pages/analyze_page.dart';
import 'package:easybudget_app/features/balance/pages/balance_page.dart';
import 'package:easybudget_app/features/home/pages/home_page.dart';
import 'package:easybudget_app/features/set/pages/set_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
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