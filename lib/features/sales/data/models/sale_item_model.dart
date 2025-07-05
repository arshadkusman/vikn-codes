// features/sales/data/models/sale_item_model.dart
import 'package:vikn_task/features/sales/domain/entities/sale_item.dart';

class SaleItemModel extends SaleItem {
  const SaleItemModel({
    required int id,
    required String voucherNo,
    required double total,
    required String date,
    required String customerName,
    required String status,
  }) : super(
         id: id,
         voucherNo: voucherNo,
         total: total,
         date: date,
         customerName: customerName,
         status: status,
       );

  factory SaleItemModel.fromJson(Map<String, dynamic> json) {
    return SaleItemModel(
      id: json['index'] ?? 0,
      voucherNo: json['VoucherNo'] ?? 'N/A',
      total: (json['GrandTotal_Rounded'] as num?)?.toDouble() ?? 0.0,
      date: json['Date'] ?? '',
      customerName: json['CustomerName'] ?? 'Unknown',
      status: json['Status'] ?? 'Pending',
    );
  }
}
