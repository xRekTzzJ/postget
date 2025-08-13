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
    _dio.options
      ..baseUrl = _host
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 5)
      ..headers = {'Content-Type': 'application/json'};

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // final token = getIt<SecureStorageService>().getToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("API Error: ${e.message}");
          return handler.next(e);
        },
      ),
    );
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

  Future<Response> post({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      return await _dio.post(url, data: body);
    } on DioException catch (e) {
      throw Exception("POST $url failed: ${e.message}");
    }
  }
}
