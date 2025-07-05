// domain/entities/sale_item.dart
class SaleItem {
  final int id;
  final String voucherNo;
  final double total;
  final String date;
  final String customerName;
  final String status;

  const SaleItem({
    required this.id,
    required this.voucherNo,
    required this.total,
    required this.date,
    required this.customerName,
    required this.status,
  });
}
