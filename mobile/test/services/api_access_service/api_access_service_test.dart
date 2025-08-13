import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/services/api_access_service/api_access_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class FakeResponse extends Fake implements Response {}

void main() {
  late MockDio mockDio;
  late ApiAccessService apiService;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Response(requestOptions: RequestOptions(path: '')));
  });

  setUp(() {
    mockDio = MockDio();
    apiService = ApiAccessService.test(mockDio);
  });

  group('ApiAccessService GET', () {
    test('должен вернуть данные при успешном запросе', () async {
      final mockResponse = Response(
        data: {'message': 'success'},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/test'),
      );

      when(
        () => mockDio.get(
          '/test',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final result = await apiService.get(url: '/test');

      expect(result.data, {'message': 'success'});
      verify(
        () => mockDio.get(
          '/test',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('должен бросать исключение при ошибке запроса', () async {
      when(
        () => mockDio.get(
          '/test',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/test'),
          message: 'Network error',
        ),
      );

      expect(
        () async => await apiService.get(url: '/test'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('ApiAccessService POST', () {
    test('должен отправить данные и вернуть ответ', () async {
      final mockResponse = Response(
        data: {'id': 1},
        statusCode: 201,
        requestOptions: RequestOptions(path: '/create'),
      );

      when(
        () => mockDio.post('/create', data: any(named: 'data')),
      ).thenAnswer((_) async => mockResponse);

      final result = await apiService.post(
        url: '/create',
        body: {'name': 'John'},
      );

      expect(result.data, {'id': 1});
      verify(() => mockDio.post('/create', data: {'name': 'John'})).called(1);
    });

    test('должен бросать исключение при ошибке POST', () async {
      when(() => mockDio.post('/create', data: any(named: 'data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/create'),
          message: 'Server error',
        ),
      );

      expect(
        () async =>
            await apiService.post(url: '/create', body: {'name': 'John'}),
        throwsA(isA<Exception>()),
      );
    });
  });
}
