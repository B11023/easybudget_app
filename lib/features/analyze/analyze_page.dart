import 'package:easybudget_app/common/models/entry_type.dart';
import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/widgets/month_switcher.dart';
import 'package:easybudget_app/common/widgets/select_card.dart';
import 'package:easybudget_app/features/analyze/transaction_pie_charts.dart';
import 'package:easybudget_app/features/analyze/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyzePage extends StatefulWidget {
  const AnalyzePage({super.key});
  @override
  State<AnalyzePage> createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<EntryProvider>().resetToNow();
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SelectCard(text: '支出分析', type: EntryType.expend),
                const SizedBox(
                  width: 45,
                ),
                SelectCard(text: '收入分析', type: EntryType.income),
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
        ));
  }
}
