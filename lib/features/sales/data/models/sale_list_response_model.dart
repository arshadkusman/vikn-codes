// features/sales/data/models/sale_list_response_model.dart

import 'sale_item_model.dart';

class SaleListResponseModel {
  final List<SaleItemModel> items;
  final int totalPages; // if API doesn’t return this, we can default to 1

  SaleListResponseModel({required this.items, required this.totalPages});

  factory SaleListResponseModel.fromJson(Map<String, dynamic> json) {
    // 1) Pull the list from "data"
    final rawList = json['data'];
    if (rawList is! List) {
      throw FormatException(
        'SaleListResponseModel: expected "data" to be List, got ${rawList.runtimeType}',
      );
    }

    final items =
        rawList
            .map((e) => SaleItemModel.fromJson(e as Map<String, dynamic>))
            .toList();

    // 2) If the API provides total pages or total count, parse it here.
    //    Otherwise, default to 1 (or calculate from count)
    final int totalPages =
        (json['total_pages'] is int) ? json['total_pages'] as int : 1;

    return SaleListResponseModel(items: items, totalPages: totalPages);
  }
}
