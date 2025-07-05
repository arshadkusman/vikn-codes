// features/profile/data/datasources/profile_remote_data_source.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:vikn_task/core/network/network_exception.dart';
import '../../../../core/network/api_client.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> fetchProfile(String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient client;
  ProfileRemoteDataSourceImpl(this.client);

  @override
  Future<ProfileModel> fetchProfile(String userId) async {
    try {
      final resp = await client.get(
        'https://api.viknbooks.com/api/v10/users/user-view/$userId/',
      );

      if (resp.statusCode != 200) {
        throw NetworkException('HTTP ${resp.statusCode}');
      }

      // Decode if necessary
      final raw = resp.data;
      final Map<String, dynamic> map =
          raw is String
              ? jsonDecode(raw) as Map<String, dynamic>
              : raw as Map<String, dynamic>;

      return ProfileModel.fromJson(map);
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
