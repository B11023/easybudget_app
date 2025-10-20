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

  // ---- 衍生統計（暫存）----
  int _totalIncome = 0, _totalExpend = 0, _totalBalance = 0;
  int _monthIncome = 0, _monthExpend = 0, _monthBalance = 0;

  // ---- Getter（唯讀）----
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

  // ---- 私有：統一重算衍生統計 ----
  void _recomputeAggregates() {
    // 全部
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

    int mi = 0, me = 0;
    for (final e in _entries) {
      final d = e.createdAt.toLocal();
      if (!d.isBefore(start) && d.isBefore(end)) {
        if (e.entryType == 'income') {
          mi += e.amount;
        } else if (e.entryType == 'expend') {
          me += e.amount;
        }
      }
    }
    _monthIncome = mi;
    _monthExpend = me;
    _monthBalance = mi - me;
  }

  // ---- 外部 API ----
  void setSelected(bool selected) {
    _isSelected = selected;
    notifyListeners();
  }

  void setEntries(List<Entry> newEntries) {
    _entries = List.of(newEntries)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _recomputeAggregates();
    notifyListeners();
  }

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
