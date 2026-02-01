import 'dart:collection';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:easybudget_app/common/models/entry.dart';
import 'package:easybudget_app/common/provider/load_status.dart';
import 'package:easybudget_app/core/network/api_client.dart';
import 'package:easybudget_app/common/services/entry_query_service.dart';

class EntryProvider extends ChangeNotifier {
  // ---- 狀態 ----
  List<Entry> _entries = [];
  LoadStatus _status = LoadStatus.idle;
  String? _error;

  //支出T 收入F
  bool _isSelected = true;

  //目前年月
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;

  // ---- 衍生統計（暫存）----
  int _totalIncome = 0, _totalExpend = 0, _totalBalance = 0;
  int _monthIncome = 0, _monthExpend = 0, _monthBalance = 0;

  // ==== Getter（唯讀）====

  // ---- datetime ----
  int get year => _year;
  int get month => _month;

  // ---- fund ----
  UnmodifiableListView<Entry> get entries => UnmodifiableListView(_entries);
  LoadStatus get status => _status;
  String? get error => _error;
  bool get isSelected => _isSelected;

  int get totalIncome => _totalIncome;
  int get totalExpend => _totalExpend;
  int get totalBalance => _totalBalance;
  int get monthIncome => _monthIncome;
  int get monthExpend => _monthExpend;
  int get monthBalance => _monthBalance;

  List<Entry> get currentMonthEntries =>
      EntryQueryService.entriesInCurrentMonth(_entries);

  Map<DateTime, List<Entry>> get groupedByDay =>
      EntryQueryService.groupCurrentMonthByDay(currentMonthEntries);

  Map<String, double> get sumByCategory =>
      EntryQueryService.sumCurrentMonthByCategory(
          currentMonthEntries, isSelected);

  // ==== 私有function ====
  //  (區間)支出收入total
  Map<String, int> _sumInRange(DateTime start, DateTime end) {
    int income = 0, expend = 0;

    for (final e in _entries) {
      final d = e.createdAt.toLocal();
      if (!d.isBefore(start) && d.isBefore(end)) {
        if (e.entryType == 'income') {
          income += e.amount;
        } else if (e.entryType == 'expend') {
          expend += e.amount;
        }
      }
    }

    return {
      'income': income,
      'expend': expend,
    };
  }

  // ---- 統一重算衍生統計 ----
  void _recomputeAggregates() {
    // 全部total
    int ti = 0, te = 0;
    for (final e in _entries) {
      if (e.entryType == 'income') {
        ti += e.amount;
      } else if (e.entryType == 'expend') {
        te += e.amount;
      }
    }
    _totalIncome = ti;
    _totalExpend = te;
    _totalBalance = ti - te;

    // 本月（半開區間 + local）
    final now = DateTime.now().toLocal();
    final start = DateTime(now.year, now.month, 1);
    final end = (now.month == 12)
        ? DateTime(now.year + 1, 1, 1)
        : DateTime(now.year, now.month + 1, 1);

    final sum = _sumInRange(start, end);
    _monthIncome = sum['income']!;
    _monthExpend = sum['expend']!;
    _monthBalance = _monthIncome - _monthExpend;
  }

  // ==== 外部 API ====
  //設定支出收入
  void setSelected(bool selected) {
    _isSelected = selected;
    notifyListeners();
  }

  //修改時間
  void previousYear() {
    _year--;
    notifyListeners();
  }

  void nextYear() {
    _year++;
    notifyListeners();
  }

  void resetToNow() {
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
    notifyListeners();
  }

  //計算那年各月支出收入
  Map<String, List<int>> getMonthlyTotalForYear() {
    final List<int> incomes = [];
    final List<int> expends = [];
    final List<int> balance = [];

    for (int m = 1; m <= 12; m++) {
      final start = DateTime(year, m, 1);
      final end =
          (m == 12) ? DateTime(year + 1, 1, 1) : DateTime(year, m + 1, 1);

      final sum = _sumInRange(start, end);
      final income = sum['income'] ?? 0;
      final expend = sum['expend'] ?? 0;

      incomes.add(income);
      expends.add(expend);
      balance.add(income - expend);
    }

    return {
      'income': incomes,
      'expend': expends,
      'balance': balance,
    };
  }

  //登入加載
  Future<void> loadEntries() async {
    _status = LoadStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final list = await ApiClient.fetchEntries();
      _entries = List.of(list)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _status = LoadStatus.loaded;
      _recomputeAggregates();
    } catch (e, st) {
      _error = e.toString();
      _status = LoadStatus.error;
      if (kDebugMode) log('loadEntries error: $_error\n$st');
    }
    notifyListeners();
  }

  //新增data
  Future<bool> addEntry(Entry entry) async {
    try {
      final saved = await ApiClient.createEntry(entry);
      _entries.add(saved);
      _entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _recomputeAggregates();
      notifyListeners();
      return true;
    } catch (e, st) {
      _error = e.toString();
      if (kDebugMode) log('addEntry error: $_error\n$st');
      notifyListeners();
      return false;
    }
  }
}
