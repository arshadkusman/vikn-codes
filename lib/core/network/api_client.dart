import 'package:dio/dio.dart';
import 'package:vikn_task/core/network/network_exception.dart';
import 'package:vikn_task/core/utils/app_constants.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final SecureStorage _storage;

  ApiClient(this._dio, this._storage) {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(AppConstants.tokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) {
        return handler.reject(
          DioError(
            requestOptions: e.requestOptions,
            error: NetworkException.fromDioError(e),
          ),
        );
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }
}
