import 'package:flutter/material.dart';
import 'package:flutter_obat/view/screen/penyakit/penyakit_screen.dart';
import 'package:flutter_obat/view/screen/penyakit/list_penyakit.dart';

class DynamicBottomNavBarPenyakit extends StatefulWidget {
  const DynamicBottomNavBarPenyakit({super.key});

  @override
  State<DynamicBottomNavBarPenyakit> createState() =>
      _DynamicBottomNavBarPenyakitState();
}

class _DynamicBottomNavBarPenyakitState
    extends State<DynamicBottomNavBarPenyakit> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    const PenyakitScreen(),
    const ListPenyakit(),
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
            label: 'Tambah Penyakit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Detail Penyakit',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue.shade600,
      ),
    );
  }
}
