import 'package:dio/dio.dart';
import 'package:vikn_task/core/network/network_exception.dart';
import '../../../../core/network/api_client.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  /// Throws [NetworkException] on error
  Future<LoginResponseModel> login({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<LoginResponseModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.post(
        '/users/login',
        data: {'username': username, 'password': password, 'is_mobile': true},
      );
      print('🛠  [Login] raw response.data: ${response.data}');
      return LoginResponseModel.fromJson(
        (response.data as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
