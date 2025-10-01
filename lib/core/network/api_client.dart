import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easybudget_app/common/config/env_config.dart';
import 'package:easybudget_app/common/models/entry.dart';

class ApiClient {
  static late final Dio _dio;
  static bool _interceptorAdded = false;

  static void init() {
    final base = EnvConfig.api;
    _dio = Dio(BaseOptions(
      baseUrl: base,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ));
  }

  static Future<void> setBearer(String idToken) async {
    if (_interceptorAdded) return;
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $idToken';
        return handler.next(options);
      }),
    );

    _interceptorAdded = true;
  }

  static Future<List<Entry>> fetchEntries() async {
    final resp = await _dio.get('/api/entries');
    log('status=${resp.statusCode}');

    if (resp.statusCode == 200) {
      final entries =
          (resp.data as List).map((e) => Entry.fromJson(e)).toList();

      log('list entries=$entries');
      return entries;
    }
    throw Exception('HTTP ${resp.statusCode}: ${resp.data}');
  }

  static Future<Entry> createEntry(Entry entry) async {
    try {
      final resp = await _dio.post(
        '/api/entries',
        data: entry.toJson(),
      );

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        log('statusCode:200');
        return Entry.fromJson(resp.data as Map<String, dynamic>);
      } else {
        throw Exception('HTTP ${resp.statusCode}: ${resp.data}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    }
  }
}
