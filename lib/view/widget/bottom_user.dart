import 'package:flutter/material.dart';
import 'package:flutter_obat/view/screen/user/profile_user.dart';
import 'package:flutter_obat/view/screen/about_screen.dart';
import 'package:flutter_obat/view/screen/user/dashboard_screen.dart';

class DynamicBottomNavBarUser extends StatefulWidget {
  const DynamicBottomNavBarUser({super.key});

  @override
  State<DynamicBottomNavBarUser> createState() =>
      _DynamicBottomNavBarUserState();
}

class _DynamicBottomNavBarUserState extends State<DynamicBottomNavBarUser> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    const DashboardScreen(),
    const MyShared(),
    const ProfileUserScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.last_page_rounded),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red.shade300,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
