import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vikn_task/features/filter/domain/entities/filter_params.dart';
import 'package:vikn_task/features/filter/presentation/pages/filter_page.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/sale_item.dart';
import '../bloc/sales_cubit.dart';
import '../bloc/sales_state.dart';

class SalesListPage extends StatefulWidget {
  const SalesListPage({super.key});

  @override
  _SalesListPageState createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  late SalesCubit _cubit;
  final _searchCtrl = TextEditingController();
  List<SaleItem> _allItems = [];
  List<SaleItem> _displayedItems = [];
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SalesCubit>()..fetchSales(page: 1);
  }

  void _onSearch(String query) {
    final lower = query.trim().toLowerCase();
    setState(() {
      if (lower.isEmpty) {
        _displayedItems = List.from(_allItems);
      } else {
        _displayedItems =
            _allItems.where((e) {
              return e.voucherNo.toLowerCase().contains(lower) ||
                  e.customerName.toLowerCase().contains(lower);
            }).toList();
      }
    });
  }

  Future<void> _openFilter() async {
    final params = await Navigator.push<FilterParams>(
      context,
      MaterialPageRoute(builder: (_) => FilterPage()),
    );
    if (params != null) {
      // TODO: Apply filter logic here
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.redAccent;
      case 'invoiced':
        return Color(0xFF1C60E2);
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Invoices', style: TextStyle(color: Colors.white)),
        leading: BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: _onSearch,
                    style: TextStyle(color: Colors.white),
                    decoration: Styles.inputDecoration.copyWith(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(
                        Iconsax.search_normal,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _openFilter,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF42A5F5).withOpacity(0.1)),
                    backgroundColor: Color(0xFF42A5F5).withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  icon: Icon(Icons.filter_list, color: Color(0xFF0E74F4)),
                  label: Text(
                    'Add Filters',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SalesCubit, SalesState>(
              builder: (_, state) {
                if (state is SalesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SalesLoaded) {
                  // ✅ Only update once
                  if (!_hasLoaded) {
                    _allItems = state.items;
                    _displayedItems = List.from(_allItems);
                    _hasLoaded = true;
                  }

                  return ListView.separated(
                    itemCount: _displayedItems.length,
                    separatorBuilder: (_, __) => Divider(color: Colors.white10),
                    itemBuilder: (context, i) {
                      final sale = _displayedItems[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sale.voucherNo,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    sale.customerName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  sale.status,
                                  style: TextStyle(
                                    color: _statusColor(sale.status),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'SAR ${sale.total.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is SalesFailure) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
