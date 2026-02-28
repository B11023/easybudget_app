import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/features/analyze/analyze_page.dart';
import 'package:easybudget_app/features/balance/balance_page.dart';
import 'package:easybudget_app/features/home/home_page.dart';
import 'package:easybudget_app/features/set/set_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    BalancePage(),
    AnalyzePage(),
    SetPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          context.read<EntryProvider>().resetToNow();

          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首頁"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "餘額"),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: "分析"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "設定"),
        ],
      ),
    );
  }
}
