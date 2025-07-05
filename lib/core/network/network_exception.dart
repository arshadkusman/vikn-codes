import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  factory NetworkException.fromDioError(DioError error) {
    // You can expand this with statusCode checks, etc.
    if (error.type == DioExceptionType.connectionTimeout) {
      return NetworkException('Connection timeout');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Receive timeout');
    } else if (error.response != null) {
      return NetworkException(
        error.response?.data['message'] ?? 'Server error',
      );
    } else {
      return NetworkException('Unexpected network error');
    }
  }

  @override
  String toString() => message;
}
