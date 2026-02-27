import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/widgets/base_scaffold.dart';
import 'package:easybudget_app/common/widgets/month_switcher.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EntryProvider>().resetToNow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 2,
      body: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Text(
                  '圖表分析',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
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
              MonthSwitcher(),
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
