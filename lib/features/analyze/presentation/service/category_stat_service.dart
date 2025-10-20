import 'dart:developer';
import 'dart:math' hide log;
import 'package:easybudget_app/common/theme/app_icon.dart';
import 'package:easybudget_app/features/analyze/models/category_stat_item.dart';

class CategoryStatService {
  static List<CategoryStatItem> buildFromMonthlyMap(
    Map<String, double> sumByCategory, {
    int topN = 4,
    String othersLabel = '其他',
  }) {
    //他執行了兩次
    log('hello');
    final filtered = sumByCategory.entries.toList();

    // 依金額降冪排序
    filtered.sort((a, b) => b.value.compareTo(a.value));

    // 前 N 大 + 其他
    final top = filtered.take(max(0, topN)).toList();
    final others = filtered.skip(max(0, topN)).toList();
    final othersSum = others.fold<double>(0, (p, e) => p + e.value);

    // 合計（避免除以 0）
    final total = (top.fold<double>(0, (p, e) => p + e.value) + othersSum);
    if (total <= 0) {
      return const <CategoryStatItem>[];
    }

    String fmtAmount(num v) => '\$${v.round()}';
    String fmtPercent(num r) => '${(r * 100).toStringAsFixed(1)}%';

    // 產出前 N 大
    final result = <CategoryStatItem>[
      for (final e in top)
        CategoryStatItem(
          icon: appIcon(e.key),
          label: e.key,
          percent: fmtPercent(e.value / total),
          amount: fmtAmount(e.value),
        ),
    ];

    if (othersSum > 0) {
      result.add(
        CategoryStatItem(
          icon: appIcon(othersLabel),
          label: othersLabel,
          percent: fmtPercent(othersSum / total),
          amount: fmtAmount(othersSum),
        ),
      );
    }

    return result;
  }
}
