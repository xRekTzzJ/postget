import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiAccessService {
  final String _host = const String.fromEnvironment(
    'HOST',
    defaultValue: "http://10.0.2.2:5110",
  );

  final Dio _dio;

  ApiAccessService() : _dio = Dio() {
    _configureDio();
  }

  ApiAccessService.test(this._dio);

  void _configureDio() {
    _dio.options
      ..baseUrl = _host
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 5)
      ..headers = {'Content-Type': 'application/json'};
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.get(url, queryParameters: queryParams);
    } on DioException catch (e) {
      throw Exception("GET $url failed: ${e.message}");
    }
  }

  Future<Response> post({required String url, Object? body}) async {
    try {
      return await _dio.post(url, data: body);
    } on DioException catch (e) {
      throw Exception("POST $url failed: ${e.message}");
    }
  }
}
