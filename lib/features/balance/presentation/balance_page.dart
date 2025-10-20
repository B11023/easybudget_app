import 'dart:developer';

import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:easybudget_app/features/balance/presentation/balance_dialog.dart';
import 'package:easybudget_app/common/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  bool _hideDoller = true;
  @override
  Widget build(BuildContext context) {
    dynamic doller = context.watch<EntryProvider>().totalBalance;
    return BaseScaffold(
        currentIndex: 1,
        body: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: AppColors.main,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, top: 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            _hideDoller
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _hideDoller
                                ? AppColors.lightFont
                                : AppColors.font,
                            size: 35.0,
                          ),
                          onPressed: () {
                            setState(() {
                              _hideDoller = !_hideDoller; // 切換顯示/隱藏
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '錢包餘額',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.font,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '資產 NT \$  ${_hideDoller ? "******" : doller}',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.font,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  color: AppColors.invist,
                  elevation: 4,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      await showDialog<String>(
                        context: context,
                        useRootNavigator: true,
                        builder: (ctx) => const BalanceDialog(),
                      );

                      log("Card tapped!");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        children: [
                          Icon(
                            Icons.savings_outlined,
                            color: AppColors.font,
                            size: 50.0,
                          ),
                          Text(
                            '   存錢筒',
                            style:
                                TextStyle(color: AppColors.font, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
