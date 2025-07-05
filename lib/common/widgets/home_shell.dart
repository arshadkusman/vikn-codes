import 'package:flutter/material.dart';
import 'package:vikn_task/common/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:vikn_task/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:vikn_task/features/notification/presentation/pages/notification_page.dart';
import 'package:vikn_task/features/profile/presentation/pages/profile_page.dart';
import 'package:vikn_task/features/share/presentation/pages/share_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  _HomeShellState createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final _pages = [
    const DashboardPage(),
    SharePage(),
    NotificationPage(),
    const ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Each page has its own AppBar if needed
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onIconPressed: _onTap,
      ),
    );
  }
}
