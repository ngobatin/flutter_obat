import 'package:flutter/material.dart';
import 'package:flutter_obat/view/screen/user/data_obat.dart';
import 'package:flutter_obat/view/screen/user/data_penyakit.dart';
import 'package:flutter_obat/view/screen/user/data_rs.dart';
import 'package:flutter_obat/view/widget/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> categories = [
    {
      "image": "assets/images/medicine.png",
      "text": "Obat",
      "data": "10",
      "screen": const DataObat()
    },
    {
      "image": "assets/images/disease.png",
      "text": "Penyakit",
      "data": "10",
      "screen": const DataPenyakit()
    },
    {
      "image": "assets/images/hospital.png",
      "text": "Rumah Sakit",
      "data": "10",
      "screen": const DataRS()
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            categories.length,
            (index) => DashboardCard(
              image: categories[index]['image'],
              text: categories[index]['text'],
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => categories[index]['screen'],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
