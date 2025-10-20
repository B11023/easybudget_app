import 'dart:developer';

import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/features/analyze/models/category_stat_item.dart';
import 'package:easybudget_app/features/analyze/presentation/service/category_stat_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select<EntryProvider, List<CategoryStatItem>>((p) {
      return CategoryStatService.buildFromMonthlyMap(
        p.sumByCategory,
        topN: 4,
        othersLabel: '其他',
      );
    });
    if (items.isEmpty) {
      return const Text('本月無支出資料');
    }

    return Column(
      children: [
        for (final it in items)
          SizedBox(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(it.icon),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      it.percent,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(''),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      it.amount,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
