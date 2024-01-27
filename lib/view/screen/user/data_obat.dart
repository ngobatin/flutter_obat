import 'package:flutter/material.dart';
import 'package:flutter_obat/model/obat_model.dart';
import 'package:flutter_obat/service/api_obat.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DataObat extends StatefulWidget {
  const DataObat({super.key});

  @override
  State<DataObat> createState() => _DataObatState();
}

class _DataObatState extends State<DataObat> {
  final ApiObat _dataService = ApiObat();
  List<ObatModel> obat = [];

  @override
  void initState() {
    super.initState();
    _dataService.getAllObat().then((value) {
      setState(() {
        obat = value?.toList() ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Psikofarmaka",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: obat.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: obat[index].gambar,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(obat[index].namaObat),
                      trailing: ElevatedButton(
                        onPressed: () {
                          _showDetailsBottomSheet(context, obat[index]);
                        },
                        child: const Text('Details'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show details in a BottomSheet
  void _showDetailsBottomSheet(BuildContext context, ObatModel obatModel) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Details Obat",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Jenis Obat: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  obatModel.jenisObat,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Nama Obat: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  obatModel.namaObat,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Deskripsi Obat: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  obatModel.deskripsi,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the BottomSheet
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
