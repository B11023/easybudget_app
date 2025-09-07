import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easybudget_app/common/config/env_config.dart';

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

  static void setBearer(String idToken) {
    if (_interceptorAdded) return;
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $idToken';
        return handler.next(options);
      }),
    );
    _interceptorAdded = true;
  }

  /// 若你的 /api/entries 回的是「陣列」，回傳 List<dynamic>
  static Future<List<dynamic>> fetchEntries() async {
    try {
      final resp = await _dio.get('/api/entries');
      log('status=${resp.statusCode}');
      if (resp.statusCode == 200) {
        // Dio 已自動解析 JSON；entries 多半是 List
        final data = resp.data;
        if (data is List) return data;
        // 若後端回的是物件包陣列，可按需調整 key
        if (data is Map && data['entries'] is List) {
          return data['entries'] as List;
        }
        throw Exception('Unexpected JSON shape: ${resp.data.runtimeType}');
      } else {
        throw Exception('HTTP ${resp.statusCode}: ${resp.data}');
      }
    } on DioException catch (e) {
      log('Dio error: ${e.message}', error: e, stackTrace: e.stackTrace);
      rethrow;
    }
  }

  /// 若你有需要打根目錄 "/"（回 Map）
  static Future<Map<String, dynamic>> fetchRoot() async {
    final resp = await _dio.get('/');
    if (resp.statusCode == 200) {
      return Map<String, dynamic>.from(resp.data);
    } else {
      throw Exception('HTTP ${resp.statusCode}: ${resp.data}');
    }
  }
}
