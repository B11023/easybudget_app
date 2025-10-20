import 'dart:developer';

import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:easybudget_app/common/theme/app_icon.dart';
import 'package:easybudget_app/common/widgets/base_scaffold.dart';
import 'package:easybudget_app/common/widgets/select_card.dart';
import 'package:easybudget_app/features/analyze/presentation/widget/transaction_pie_charts.dart';
import 'package:easybudget_app/features/analyze/presentation/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyzePage extends StatefulWidget {
  const AnalyzePage({super.key});
  @override
  State<AnalyzePage> createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  //支出T 收入F
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 2,
      body: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                      // width: 90.0,
                      ),
                  Text(
                    '圖表分析',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.font,
                    ),
                  ),
                  SizedBox(
                      // child: Row(
                      //   children: [
                      //     Icon(
                      //       Icons.arrow_back_ios,
                      //       size: 25,
                      //       color: AppColors.font,
                      //     ),
                      //     Icon(
                      //       Icons.calendar_month,
                      //       size: 35,
                      //       color: AppColors.font,
                      //     ),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     Icon(
                      //       Icons.arrow_forward_ios,
                      //       size: 25,
                      //       color: AppColors.font,
                      //     )
                      //   ],
                      // ),
                      )
                ],
              )),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectCard(text: '支出分析', type: true),
                  const SizedBox(
                    width: 45,
                  ),
                  SelectCard(text: '收入分析', type: false),
                ],
              ),
              TransactionPieChart(),
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TransactionList(),
              ),
            ],
          )),
    );
  }
}
