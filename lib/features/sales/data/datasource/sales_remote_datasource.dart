// features/sales/data/datasources/sales_remote_data_source.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:vikn_task/core/network/network_exception.dart';
import '../../../../core/network/api_client.dart';
import '../models/sale_list_response_model.dart';

abstract class SalesRemoteDataSource {
  Future<SaleListResponseModel> fetchSales({
    required String userId,
    required int pageNo,
  });
}

class SalesRemoteDataSourceImpl implements SalesRemoteDataSource {
  final ApiClient client;
  SalesRemoteDataSourceImpl(this.client);

  @override
  Future<SaleListResponseModel> fetchSales({
    required String userId,
    required int pageNo,
  }) async {
    try {
      // ← Full URL for viknbooks.com
      final response = await client.post(
        'https://www.api.viknbooks.com/api/v10/sales/sale-list-page/',
        data: {
          'BranchID': 1,
          'CompanyID': '1901b825-fe6f-418d-b5f0-7223d0040d08',
          'CreatedUserID': userId,
          'PriceRounding': 2,
          'page_no': pageNo,
          'items_per_page': 10,
          'type': 'Sales',
          'WarehouseID': 1,
        },
      );

      print('🔍 Sales URL: ${response.realUri}');
      print('🔍 Status: ${response.statusCode}');
      print('🔍 Body: ${response.data}');

      if (response.statusCode != 200) {
        throw NetworkException('HTTP ${response.statusCode}');
      }

      final raw = response.data;
      final Map<String, dynamic> map = raw is String
          ? jsonDecode(raw) as Map<String, dynamic>
          : raw as Map<String, dynamic>;

      return SaleListResponseModel.fromJson(map);
    } on DioError catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
