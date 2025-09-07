import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

//不知道放甚麼 待修

class BalanceDialog extends StatelessWidget {
  const BalanceDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //折線圖資料
    List<FlSpot> spots = const [
      FlSpot(0, 1.00),
      FlSpot(1, -100),
      FlSpot(2, 100),
      FlSpot(3, 1.00),
      FlSpot(4, 300),
      FlSpot(5, 2.00),
      FlSpot(6, 200),
      FlSpot(7, 100),
      FlSpot(8, 200),
      FlSpot(9, 100),
      FlSpot(10, 200),
      FlSpot(11, 100),
      FlSpot(12, 200),
    ];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 40, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.lightMain,
              ),
              child: Text('圖表分析',
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.font,
                      fontWeight: FontWeight.bold)),
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
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          meta: meta,
                          space: 10,
                          child: Text('\$ ${value.toInt()}', textAlign: TextAlign.right),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() == 0) {
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
