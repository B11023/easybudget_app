import 'dart:developer';

import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/services/app_currency.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class BalanceDialog extends StatelessWidget {
  const BalanceDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //折線圖資料
    final provider = context.watch<EntryProvider>();
    final result = provider.getMonthlyTotalForYear();
    final balance = result['balance']!;
    const int monthCount = 12;

    final List<FlSpot> spots = List.generate(
      monthCount,
      (index) => FlSpot(
        (index + 1).toDouble(),
        balance[index].toDouble(),
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 40, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text('各月資產',
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        provider.previousYear();
                        debugPrint('year--');
                      },
                    ),
                    Text(
                      '${provider.year}年',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        provider.nextYear();
                        debugPrint('year++');
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                      left: BorderSide.none,
                      top: BorderSide.none,
                      right: BorderSide.none,
                    ),
                  ),
                  gridData: const FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 60,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.max && value != 0) {
                              return const SizedBox.shrink();
                            }
                            return SideTitleWidget(
                              meta: meta,
                              space: 10,
                              child: Text(formatAmount(value),
                                  textAlign: TextAlign.right),
                            );
                          }),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          //刪除一月
                          if (value.toInt() == 1) {
                            return const SizedBox.shrink();
                          }
                          return SideTitleWidget(
                            meta: meta,
                            space: 8,
                            child: Text('${value.toInt()} 月'),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  baselineX: 0,
                  lineBarsData: [
                    LineChartBarData(
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      spots: spots,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
