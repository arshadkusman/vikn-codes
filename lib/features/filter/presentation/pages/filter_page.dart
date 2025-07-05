// features/filter/presentation/pages/filter_page.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../filter/domain/entities/filter_params.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // Quick‑select period options
  final _periodOptions = ['This Month', 'Last Month', 'This Year'];
  String _selectedPeriod = 'This Month';

  // Date range
  DateTime? _fromDate;
  DateTime? _toDate;
  final _dateFormat = DateFormat('dd/MM/yyyy');

  // Status toggles
  final _statusOptions = ['Pending', 'Invoiced', 'Cancelled'];
  String _selectedStatus = 'Pending';

  // Customer dropdown & chips
  final _customerOptions = ['savad farooque', 'alice', 'bob'];
  String? _selectedCustomer;
  final List<String> _chosenCustomers = [];

  Future<void> _pickDate(bool isFrom) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        if (isFrom)
          _fromDate = picked;
        else
          _toDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = Color(0xFF0E74F4);
    final cardBg = Color(0xFFFFFFFF).withOpacity(0.1);

    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text('Filters', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Iconsax.eye, color: accent),
            onPressed: () {
              // TODO: preview filter
            },
          ),
          TextButton(
            onPressed: () {
              final params = FilterParams(
                fromDate: _fromDate,
                toDate: _toDate,
                status: _selectedStatus,
                period: _selectedPeriod,
                customer: _chosenCustomers,
              );
              Navigator.pop(context, params);
            },
            child: Text('Filter', style: TextStyle(color: accent)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.white10, height: 1),
            SizedBox(height: 10),
            // Period dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: cardBg,
                      value: _selectedPeriod,
                      items:
                          _periodOptions
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(
                                    p,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _selectedPeriod = v!),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 18),

            // Date range pickers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(
                children: [
                  _DateButton(
                    label:
                        _fromDate != null
                            ? _dateFormat.format(_fromDate!)
                            : _dateFormat.format(DateTime.now()),
                    onTap: () => _pickDate(true),
                  ),
                  //SizedBox(width: 2),
                  _DateButton(
                    label:
                        _toDate != null
                            ? _dateFormat.format(_toDate!)
                            : _dateFormat.format(DateTime.now()),
                    onTap: () => _pickDate(false),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Divider(color: Colors.white10, height: 1),

            SizedBox(height: 14),

            // Status toggles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    _statusOptions.map((s) {
                      final selected = s == _selectedStatus;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedStatus = s),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected ? accent : cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              s,
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.white70,
                                fontWeight:
                                    selected
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: 24),

            // Customer dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: cardBg,
                    hint: Text(
                      'Customer',
                      style: TextStyle(color: Colors.white54),
                    ),
                    value: _selectedCustomer,
                    isExpanded: true,
                    items:
                        _customerOptions
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(
                                  c,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (v) {
                      if (v != null && !_chosenCustomers.contains(v)) {
                        setState(() {
                          _chosenCustomers.add(v);
                          _selectedCustomer = null;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            Divider(color: Colors.white10, height: 1),

            SizedBox(height: 16),

            // Selected customer chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children:
                    _chosenCustomers.map((name) {
                      return Chip(
                        backgroundColor: Color(0xFF0E74F4).withOpacity(0.4),
                        shape: StadiumBorder(),
                        label: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                        deleteIcon: Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xff0A9EF3),
                        ),
                        onDeleted: () {
                          setState(() => _chosenCustomers.remove(name));
                        },
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A helper widget for the date pickers
class _DateButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _DateButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
            decoration: BoxDecoration(
              color: Color(0xFF42A5F5).withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.calendar5, color: Color(0xff0E75F4), size: 22),
                SizedBox(width: 8),
                Text(label, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
