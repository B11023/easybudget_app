import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        unselectedItemColor: AppColors.lightFont,
        selectedItemColor: AppColors.font,
        backgroundColor: AppColors.main,
        
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, "/");
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, "/balance");
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, "/analyze");
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, "/setting");
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: "首頁"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "餘額"),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart), label: "分析"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "設定"),
        ],
      ),
    );
  }
}
