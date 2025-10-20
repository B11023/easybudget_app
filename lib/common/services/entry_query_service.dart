import 'package:collection/collection.dart';
import 'package:easybudget_app/common/models/entry.dart';

class EntryQueryService {
  static ({DateTime start, DateTime end}) _monthRange(DateTime anchor) {
    final start = DateTime(anchor.year, anchor.month, 1);
    final end = DateTime(anchor.year, anchor.month + 1, 1)
        .subtract(const Duration(milliseconds: 1));
    return (start: start, end: end);
  }

  /// 當月所有資料（以裝置本地時區 DateTime 為準）
  static List<Entry> entriesInCurrentMonth(List<Entry> entries,
      {DateTime? now}) {
    final anchor = now ?? DateTime.now();
    final r = _monthRange(anchor);
    return entries
        .where((e) =>
            !e.createdAt.isBefore(r.start) && !e.createdAt.isAfter(r.end))
        .toList();
  }

  /// 當月依「日」分組（yyyy-mm-dd -> 當天的 entries）
  static Map<DateTime, List<Entry>> groupCurrentMonthByDay(List<Entry> entries,
      {DateTime? now}) {
    final start = DateTime.now();
    final monthEntries = entriesInCurrentMonth(entries, now: start);
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
      List<Entry> entries, bool isSelected,
      {DateTime? now}) {
    final monthEntries = entriesInCurrentMonth(entries, now: now);
    final map = <String, double>{};

    String type = isSelected ? 'expend' : 'income';

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
