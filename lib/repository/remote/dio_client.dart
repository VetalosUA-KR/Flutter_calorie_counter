import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio _dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://world.openfoodfacts.org/',
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
      ),
    );

    // Добавляем интерсептор логирования (аналог HttpLoggingInterceptor.Level.BODY)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
      logPrint: (object) {
        if (kDebugMode) {
          print(object); // Логирование только в режиме отладки
        }
      },
    ));

    // Кастомный интерсептор (можно добавить логику, аналогичную ChuckerInterceptor)
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print('Request: ${options.method} ${options.uri}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print('Response: ${response.statusCode} ${response.data}');
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          print('Error: ${error.message}');
        }
        return handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;
}