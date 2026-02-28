import 'package:dio/dio.dart';
import 'package:easybudget_app/common/config/env_config.dart';
import 'package:easybudget_app/common/models/entry.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EnvConfig.api,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  static void setBearer(String idToken) {
    _dio.interceptors.clear();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $idToken';
          return handler.next(options);
        },
      ),
    );
  }

  static Future<List<Entry>> fetchEntries() async {
    final resp = await _dio.get('/api/entries');

    if (resp.statusCode == 200) {
      return (resp.data as List).map((e) => Entry.fromJson(e)).toList();
    }

    throw Exception('Fetch entries failed');
  }

  static Future<Entry> createEntry(Entry entry) async {
    final resp = await _dio.post(
      '/api/entries',
      data: entry.toJson(),
    );

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Entry.fromJson(resp.data);
    }

    throw Exception('Create entry failed');
  }
}
