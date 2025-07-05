import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/styles.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accentBlue = Color(0xFF42A5F5);
    final darkBg = Color(0xff000000);

    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              // Top bar
              Row(
                children: [
                  // Logo + name
                  Image.asset('assets/brand_logo.png', height: 40),
                  Spacer(),
                  // Avatar with notification dot
                  GestureDetector(
                    onTap:() {
                                        Navigator.pushNamed(context, '/profile');

                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: darkBg,
                          backgroundImage: AssetImage('assets/avatar.png'),
                          //child: Image.asset('assets/avatar.png'),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Revenue Card
              _RevenueCard(accentBlue: accentBlue),

              SizedBox(height: 24),

              // Bookings and Invoices cards
              _StatsCard(
                icon: Icons.calendar_today_outlined,
                iconBg: Colors.white.withOpacity(0.1),
                title: 'Bookings',
                value: '123',
                subtitle: 'Reserved',
                accent: accentBlue,
                onTap: () {
                  // Navigate to bookings page
                },
              ),
              SizedBox(height: 16),
              _StatsCard(
                icon: Icons.receipt_long,
                iconBg: accentBlue.withOpacity(0.1),
                title: 'Invoices',
                value: '10,232.00',
                subtitle: 'Rupees',
                accent: accentBlue,
                onTap: () {
                  // Navigate to invoices page
                  Navigator.pushNamed(context, '/sales');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The top card showing revenue and the line chart.
class _RevenueCard extends StatefulWidget {
  final Color accentBlue;
  const _RevenueCard({required this.accentBlue});

  @override
  __RevenueCardState createState() => __RevenueCardState();
}

class __RevenueCardState extends State<_RevenueCard> {
  int _selectedDay = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.1),
        borderRadius: Styles.cardRadius,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header: total / change / label
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SAR 2,78,000.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '+21% than last month',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                  ),
                ],
              ),
              Spacer(),
              Text(
                'Revenue',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Line chart
          AspectRatio(
            aspectRatio: 1.7,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 1),
                      FlSpot(1, 2.5),
                      FlSpot(2, 4),
                      FlSpot(3, 3.5),
                      FlSpot(4, 3),
                      FlSpot(5, 3.2),
                      FlSpot(6, 2.8),
                    ],
                    isCurved: true,
                    color: widget.accentBlue,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: widget.accentBlue.withOpacity(0.3),
                    ),
                  ),
                ],
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    VerticalLine(x: 2, color: Colors.white30, strokeWidth: 1),
                  ],
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 5,
              ),
            ),
          ),

          SizedBox(height: 12),
          Text("September 2023", style: TextStyle(color: Colors.white)),

          SizedBox(height: 16),

          // Date selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(8, (i) {
              final day = (i + 1).toString().padLeft(2, '0');
              final isSelected = i + 1 == _selectedDay;
              return GestureDetector(
                onTap: () => setState(() => _selectedDay = i + 1),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? widget.accentBlue : Color(0xFF1E1E2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    day,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// A reusable card for Bookings/Invoices.
class _StatsCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String value;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  const _StatsCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.1),
        borderRadius: Styles.cardRadius,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          // Icon pill
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: accent),
          ),

          SizedBox(width: 16),

          // Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),

          Spacer(),

          // Arrow
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: onTap,
              child: Icon(Iconsax.arrow_right_1, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
