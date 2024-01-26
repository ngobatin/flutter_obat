import 'package:flutter/material.dart';
// import 'package:flutter_obat/view/screen/detail_screen.dart';
import 'package:flutter_obat/view/screen/user/data_obat.dart';
import 'package:flutter_obat/view/screen/user/data_penyakit.dart';
import 'package:flutter_obat/view/screen/user/data_rs.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Contoh data
  // List<String> obatList = ['Paracetamol', 'Aspirin', 'Antibiotik'];
  // List<String> penyakitList = ['Flu', 'Demam', 'Pilek'];
  // List<String> rumahSakitList = ['RS Awal Bros', 'RS Mitra', 'RS Sentosa'];

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
          children: [
            buildCard("Obat", "assets/images/medicine.png"),
            buildCard("Penyakit", "assets/images/disease.png"),
            buildCard("Rumah Sakit", "assets/images/hospital.png"),
          ],
        ),
      ),
    );
  }

  Card buildCard(String title, String imageUrl) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  // DetailScreen(data: data, title: '$title Detail')
                  const DataObat(),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DataRS(),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DataPenyakit(),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: 100,
              width: 100,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
