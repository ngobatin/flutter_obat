import 'package:flutter/material.dart';

class ObatScreen extends StatefulWidget {
  const ObatScreen({Key? key}) : super(key: key);

  @override
  State<ObatScreen> createState() => _ObatScreenState();
}

class Obat {
  String jenis;
  String nama;
  String deskripsi;

  Obat(this.jenis, this.nama, this.deskripsi);
}

class _ObatScreenState extends State<ObatScreen> {
  final TextEditingController _obatJenisController = TextEditingController();
  final TextEditingController _obatNamaController = TextEditingController();
  final TextEditingController _obatDescriptionController =
      TextEditingController();

  List<Obat> obatList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Psikofarmaka",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade900,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Data Obat",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _obatJenisController,
                  decoration: InputDecoration(
                    labelText: 'Jenis Obat',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _obatNamaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Obat',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _obatDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Obat newObat = Obat(
                            _obatJenisController.text,
                            _obatNamaController.text,
                            _obatDescriptionController.text,
                          );
                          obatList.add(newObat);

                          // Clear text fields after adding obat
                          _obatJenisController.clear();
                          _obatNamaController.clear();
                          _obatDescriptionController.clear();
                        });
                      },
                      child: Text('Add Obat'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Implement edit functionality here
                        // You can open a dialog or navigate to a new screen for editing
                      },
                      child: Text('Edit Obat'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Implement delete functionality here
                          if (obatList.isNotEmpty) {
                            obatList.removeLast();
                          }
                        });
                      },
                      child: Text('Delete Obat'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: obatList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jenis Obat: ${obatList[index].jenis}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Nama Obat: ${obatList[index].nama}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Deskripsi: ${obatList[index].deskripsi}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      // Add edit and delete buttons to each ListTile
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Implement edit functionality here
                              // You can open a dialog or navigate to a new screen for editing
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                // Implement delete functionality here
                                obatList.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
