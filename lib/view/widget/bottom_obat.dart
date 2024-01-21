import 'package:flutter/material.dart';
import 'package:flutter_obat/view/screen/obat/obat_screen.dart';
import 'package:flutter_obat/view/screen/obat/list_obat.dart';

class DynamicBottomNavBarObat extends StatefulWidget {
  const DynamicBottomNavBarObat({super.key});

  @override
  State<DynamicBottomNavBarObat> createState() =>
      _DynamicBottomNavBarObatState();
}

class _DynamicBottomNavBarObatState extends State<DynamicBottomNavBarObat> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    const ObatScreen(),
    const ListObat(),
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
            label: 'Tambah Obat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Detail Obat',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue.shade600,
      ),
    );
  }
}
