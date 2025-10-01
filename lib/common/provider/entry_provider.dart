import 'dart:developer';

import 'package:easybudget_app/common/models/entry.dart';
import 'package:easybudget_app/common/provider/load_status.dart';
import 'package:easybudget_app/core/network/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:easybudget_app/common/services/entry_query_service.dart';

class EntryProvider extends ChangeNotifier {
  List<Entry> _entries = [];
  LoadStatus _status = LoadStatus.idle;
  String? _error;

  List<Entry> get entries => _entries;
  LoadStatus get status => _status;
  String? get error => _error;

  // init
  void setEntries(List<Entry> newEntries) {
    _entries = newEntries;
    notifyListeners();
  }

  //新增data
  Future<void> addEntry(Entry entry) async {
    final saved = await ApiClient.createEntry(entry);
    _entries.add(saved);
    log('newEntry:$entry');
    notifyListeners();
  }

  //載入渲染
  Future<void> loadEntries() async {
    _status = LoadStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final list = await ApiClient.fetchEntries();
      _entries = list;
      _status = LoadStatus.loaded;
    } catch (e) {
      _error = e.toString();
      _status = LoadStatus.error;
    }
    notifyListeners();
  }

  // 當月data
  List<Entry> get currentMonthEntries {
    return EntryQueryService.entriesInCurrentMonth(_entries);
  }

  // 當月依照日期分組data
  Map<DateTime, List<Entry>> get groupedByDay {
    return EntryQueryService.groupCurrentMonthByDay(_entries);
  }

  // 當月依照種類分類data
  Map<String, double> get sumByCategory {
    return EntryQueryService.sumCurrentMonthByCategory(_entries);
  }

  //目前總花費
  int get countSum {
    return _entries.fold<int>(0, (sum, e) {
      if (e.entryType == 'income') {
        return sum + e.amount;
      } else if (e.entryType == 'expend') {
        return sum - e.amount;
      }
      return sum;
    });
  }
}
