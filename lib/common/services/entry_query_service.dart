import 'package:collection/collection.dart';
import 'package:easybudget_app/common/models/entry.dart';
import 'package:easybudget_app/common/models/entry_type.dart';

class EntryQueryService {
  static ({DateTime start, DateTime end}) _monthRange(DateTime anchor) {
    final start = DateTime(anchor.year, anchor.month, 1);
    final end = DateTime(anchor.year, anchor.month + 1, 1)
        .subtract(const Duration(milliseconds: 1));
    return (start: start, end: end);
  }

  //totalBalance
  static int totalBalance(List<Entry> entries) {
    int total = 0;

    for (final e in entries) {
      if (e.entryType == 'income') {
        total += e.amount;
      }

      if (e.entryType == 'expend') {
        total -= e.amount;
      }
    }

    return total;
  }

  //當年所有月份balance
  static Map<int, int> monthlyTotalForYear(
    List<Entry> entries,
    int year,
  ) {
    final result = {for (int i = 1; i <= 12; i++) i: 0};

    for (final e in entries) {
      if (e.createdAt.year != year) continue;
      if (e.entryType == EntryType.income.name) {
        result[e.createdAt.month] = result[e.createdAt.month]! + e.amount;
      }
      if (e.entryType == EntryType.expend.name) {
        result[e.createdAt.month] = result[e.createdAt.month]! - e.amount;
      }
    }

    return result;
  }

  /// 當月所有資料（以裝置本地時區 DateTime 為準）
  static List<Entry> entriesInCurrentMonth(
      List<Entry> entries, DateTime anchor) {
    final r = _monthRange(anchor);
    return entries
        .where((e) =>
            !e.createdAt.isBefore(r.start) && !e.createdAt.isAfter(r.end))
        .toList();
  }

  /// 當月依「日」分組（yyyy-mm-dd -> 當天的 entries）
  static Map<DateTime, List<Entry>> groupCurrentMonthByDay(
      List<Entry> entries, DateTime anchor) {
    final monthEntries = entriesInCurrentMonth(entries, anchor);
    final grouped = groupBy(
        monthEntries,
        (Entry e) =>
            DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day));

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    for (final key in sortedKeys) {
      final entriesOfDay = grouped[key]!
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      grouped[key] = entriesOfDay;
    }
    return grouped;
  }

  /// 當月依「類別」加總
  static Map<String, double> sumCurrentMonthByCategory(
      List<Entry> entries, EntryType entryType, DateTime anchor) {
    final monthEntries = entriesInCurrentMonth(entries, anchor);
    final map = <String, double>{};

    String type = entryType == EntryType.expend ? 'expend' : 'income';

    for (final e in monthEntries) {
      if (e.entryType != type) continue;

      map.update(
        e.category.trim(),
        (v) => v + e.amount.toDouble(),
        ifAbsent: () => e.amount.toDouble(),
      );
    }
    return map;
  }
}
