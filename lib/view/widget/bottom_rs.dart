import 'package:flutter/material.dart';
import 'package:flutter_obat/view/screen/admin/rs/rs_screen.dart';
import 'package:flutter_obat/view/screen/admin/rs/list_rs.dart';

class DynamicBottomNavBarRS extends StatefulWidget {
  const DynamicBottomNavBarRS({super.key});

  @override
  State<DynamicBottomNavBarRS> createState() => _DynamicBottomNavBarRSState();
}

class _DynamicBottomNavBarRSState extends State<DynamicBottomNavBarRS> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    const RSScreen(),
    const ListRS(),
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
            icon: Icon(Icons.add),
            label: 'Tambah RS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Detail RS',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red.shade300,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
