import 'package:flutter/material.dart';
import 'package:flutter_obat/view/screen/detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Contoh data
  List<String> obatList = ['Paracetamol', 'Aspirin', 'Antibiotik'];
  List<String> penyakitList = ['Flu', 'Demam', 'Pilek'];
  List<String> rumahSakitList = ['RS Awal Bros', 'RS Mitra', 'RS Sentosa'];

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
            buildCard("Obat", obatList, "assets/images/medicine.png"),
            buildCard("Penyakit", penyakitList, "assets/images/disease.png"),
            buildCard(
                "Rumah Sakit", rumahSakitList, "assets/images/hospital.png"),
          ],
        ),
      ),
    );
  }

  Card buildCard(String title, List<String> data, String imageUrl) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailScreen(data: data, title: '$title Detail'),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.fill,
              height: 100, // Specify the height as needed
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
            Text(data.join(', ')),
          ],
        ),
      ),
    );
  }
}
