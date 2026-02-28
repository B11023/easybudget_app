import 'dart:collection';
import 'package:easybudget_app/common/models/entry_type.dart';
import 'package:easybudget_app/common/provider/load_status.dart';
import 'package:flutter/material.dart';
import 'package:easybudget_app/common/models/entry.dart';
import 'package:easybudget_app/core/network/api_client.dart';
import 'package:easybudget_app/common/services/entry_query_service.dart';

class EntryProvider extends ChangeNotifier {
  LoadStatus _status = LoadStatus.idle;
  String? _error;

  LoadStatus get status => _status;
  String? get error => _error;

  List<Entry> _entries = [];
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;

  //確認支出或收入
  EntryType _selectedType = EntryType.income;
  EntryType get selectedType => _selectedType;
  DateTime get _anchor => DateTime(_year, _month);

  UnmodifiableListView<Entry> get entries => UnmodifiableListView(_entries);

  int get year => _year;
  int get month => _month;

  void setSelectedType(EntryType type) {
    _selectedType = type;
    notifyListeners();
  }

  int get totalBalance => EntryQueryService.totalBalance(
        _entries,
      );

  /// 當月所有資料
  List<Entry> get currentMonthEntries =>
      EntryQueryService.entriesInCurrentMonth(_entries, _anchor);

  /// 當月收入
  int get monthIncome => currentMonthEntries
      .where((e) => e.entryType == 'income')
      .fold(0, (sum, e) => sum + e.amount);

  /// 當月支出
  int get monthExpense => currentMonthEntries
      .where((e) => e.entryType == 'expend')
      .fold(0, (sum, e) => sum + e.amount);

  /// 當月餘額
  int get monthBalance => monthIncome - monthExpense;

  /// 分組（給 UI 用）
  Map<DateTime, List<Entry>> get groupedByDay =>
      EntryQueryService.groupCurrentMonthByDay(_entries, _anchor);

  Map<int, int> getMonthlyTotalForYear() {
    return EntryQueryService.monthlyTotalForYear(
      _entries,
      _year,
    );
  }

  Future<void> loadEntries() async {
    _status = LoadStatus.loading;
    notifyListeners();

    try {
      _entries = await ApiClient.fetchEntries();
      _status = LoadStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = LoadStatus.error;
    }

    notifyListeners();
  }

  //判斷支出收入
  Map<String, double> get expenseByCategory =>
      EntryQueryService.sumCurrentMonthByCategory(
          _entries, EntryType.expend, _anchor);

  Map<String, double> get incomeByCategory =>
      EntryQueryService.sumCurrentMonthByCategory(
          _entries, EntryType.income, _anchor);

  Future<void> addEntry(Entry entry) async {
    final created = await ApiClient.createEntry(entry);
    _entries.add(created);
    notifyListeners();
  }

  void resetToNow() {
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
    notifyListeners();
  }

  void nextMonth() {
    if (_month == 12) {
      _year++;
      _month = 1;
    } else {
      _month++;
    }
    notifyListeners();
  }

  void previousMonth() {
    if (_month == 1) {
      _year--;
      _month = 12;
    } else {
      _month--;
    }
    notifyListeners();
  }

  void previousYear() {
    _year--;
    notifyListeners();
  }

  void nextYear() {
    _year++;
    notifyListeners();
  }
}
