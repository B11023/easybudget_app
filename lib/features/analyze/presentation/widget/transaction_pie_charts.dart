import 'dart:developer';

import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:easybudget_app/features/analyze/presentation/widget/icon_badge.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPieChart extends StatefulWidget {
  const TransactionPieChart({super.key});

  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State<TransactionPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final sections = showingSections(context);
    final pieKey = ValueKey<int>(sections.length);
    final provider = context.watch<EntryProvider>();
    final balance =
        provider.isSelected ? provider.monthExpend : provider.monthIncome;

    String totalCount =
        provider.isSelected ? '月支出\nNT \$ -$balance' : '月收入\nNT \$ $balance';

    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Center(
              child: Text(
                totalCount,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            PieChart(
              key: pieKey,
              PieChartData(
                sectionsSpace: 1,
                centerSpaceRadius: 90,
                sections: sections,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(BuildContext context) {
    final provider = context.watch<EntryProvider>();
    final source = provider.currentMonthEntries;
    final entryTypeFilter = provider.isSelected ? 'expend' : 'income';
    final filtered = source
        .where((e) => e.entryType == entryTypeFilter && e.amount > 0)
        .toList();

    final total = filtered.fold<int>(0, (s, e) => s + e.amount);
    if (total == 0) {
      return [
        PieChartSectionData(
          color: AppColors.pieColor.last,
          title: '無資料',
          value: 1,
          titleStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          radius: 50,
        ),
      ];
    }

    final Map<String, int> sumByCategory = {};
    for (final e in filtered) {
      final key =
          (e.category.toString() != 'null') ? e.category.toString() : '未知';
      sumByCategory.update(key, (v) => v + e.amount, ifAbsent: () => e.amount);
    }

    final entriesSorted = sumByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top4 = entriesSorted.take(4).toList();
    final othersValue =
        entriesSorted.skip(4).fold<int>(0, (s, e) => s + e.value);

    final displayItems = <MapEntry<String, int>>[
      ...top4,
      if (othersValue > 0) MapEntry('其他', othersValue),
    ];

    final sections = <PieChartSectionData>[];
    for (var i = 0; i < displayItems.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;

      final label = displayItems[i].key;
      final value = displayItems[i].value.toDouble();
      final percent = (value / total * 100);
      final color = i < 4 ? AppColors.pieColor[i] : AppColors.pieColor.last;

      sections.add(
        PieChartSectionData(
          color: color,
          value: value,
          title: '${percent.toStringAsFixed(0)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: AppColors.black, blurRadius: 2)],
          ),
          badgeWidget: IconBadge(categoryKey: label),
          badgePositionPercentageOffset: .98,
        ),
      );
    }
    return sections;
  }
}
