class FilterParams {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? status;
  final String? period;
  final List<String> customer;

  FilterParams({
    this.fromDate,
    this.toDate,
    this.status,
    this.period,
    required this.customer,
  });
}
