import 'package:easybudget_app/common/models/entry.dart';

class EntryQueryService {
  static List<Entry> entriesInMonth(
      List<Entry> entries, int year, int month) {
    return entries.where((e) {
      return e.createdAt.year == year &&
             e.createdAt.month == month;
    }).toList();
  }

  static int sumIncome(List<Entry> entries) {
    return entries
        .where((e) => e.entryType == 'income')
        .fold(0, (sum, e) => sum + e.amount);
  }

  static int sumExpense(List<Entry> entries) {
    return entries
        .where((e) => e.entryType == 'expense')
        .fold(0, (sum, e) => sum + e.amount);
  }

  static int balance(List<Entry> entries) {
    return sumIncome(entries) - sumExpense(entries);
  }
}