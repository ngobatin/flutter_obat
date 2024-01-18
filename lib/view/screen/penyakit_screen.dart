import 'package:flutter/material.dart';

class PenyakitScreen extends StatefulWidget {
  const PenyakitScreen({super.key});

  @override
  State<PenyakitScreen> createState() => _PenyakitScreenState();
}

class _PenyakitScreenState extends State<PenyakitScreen> {
  TextEditingController jenisController = TextEditingController();
  TextEditingController penyakitController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController obatController = TextEditingController();

  List<Map<String, String>> penyakitList = [];

  bool isEditing = false;
  int editingIndex = -1;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Data Penyakit",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildPenyakitForm(),
            SizedBox(
              height: 20,
            ),
            _buildAddButton(),
            SizedBox(
              height: 20,
            ),
            _buildPenyakitList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPenyakitForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFormField(
          controller: jenisController,
          label: 'Jenis Penyakit',
          hintText: 'Masukkan jenis penyakit',
        ),
        SizedBox(height: 15),
        _buildFormField(
          controller: penyakitController,
          label: 'Nama Penyakit',
          hintText: 'Masukkan nama penyakit',
        ),
        SizedBox(height: 15),
        _buildFormField(
          controller: deskripsiController,
          label: 'Deskripsi',
          hintText: 'Masukkan deskripsi penyakit',
          maxLines: 3, // Multiline input
        ),
        SizedBox(height: 15),
        _buildFormField(
          controller: obatController,
          label: 'Obat',
          hintText: 'Masukkan obat yang direkomendasikan',
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orange.shade900, width: 2),
        ),
      ),
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () {
        if (isEditing) {
          _updatePenyakit();
        } else {
          _addPenyakit();
        }
      },
      child: Text(isEditing ? 'Edit Penyakit' : 'Add Data'),
    );
  }

  void _addPenyakit() {
    setState(() {
      String jenisPenyakit = jenisController.text;
      String namaPenyakit = penyakitController.text;
      String deskripsi = deskripsiController.text;
      String obat = obatController.text;

      if (namaPenyakit.isNotEmpty &&
          jenisPenyakit.isNotEmpty &&
          deskripsi.isNotEmpty &&
          obat.isNotEmpty) {
        Map<String, String> penyakitData = {
          'Jenis Penyakit': jenisPenyakit,
          'Nama Penyakit': namaPenyakit,
          'Deskripsi': deskripsi,
          'Obat': obat,
        };
        penyakitList.add(penyakitData);
        _clearControllers();
      }
    });
  }

  void _updatePenyakit() {
    setState(() {
      if (editingIndex != -1) {
        String jenisPenyakit = jenisController.text;
        String namaPenyakit = penyakitController.text;
        String deskripsi = deskripsiController.text;
        String obat = obatController.text;

        if (namaPenyakit.isNotEmpty &&
            jenisPenyakit.isNotEmpty &&
            deskripsi.isNotEmpty &&
            obat.isNotEmpty) {
          penyakitList[editingIndex] = {
            'Jenis Penyakit': jenisPenyakit,
            'Nama Penyakit': namaPenyakit,
            'Deskripsi': deskripsi,
            'Obat': obat,
          };
          _clearControllers();
          isEditing = false;
          editingIndex = -1;
        }
      }
    });
  }

  void _clearControllers() {
    jenisController.clear();
    penyakitController.clear();
    deskripsiController.clear();
    obatController.clear();
  }

  Widget _buildPenyakitList() {
    return Expanded(
      child: ListView.builder(
        itemCount: penyakitList.length,
        itemBuilder: (context, index) {
          return _buildPenyakitCard(penyakitList[index], index);
        },
      ),
    );
  }

  Widget _buildPenyakitCard(Map<String, String> penyakitData, int index) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          penyakitData['Jenis Penyakit'] ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(penyakitData['Nama Penyakit'] ?? ''),
            SizedBox(height: 5),
            Text(penyakitData['Deskripsi'] ?? ''),
            SizedBox(height: 5),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _startEditing(index, penyakitData);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deletePenyakit(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startEditing(int index, Map<String, String> penyakitData) {
    setState(() {
      isEditing = true;
      editingIndex = index;
      jenisController.text = penyakitData['Jenis Penyakit'] ?? '';
      penyakitController.text = penyakitData['Nama Penyakit'] ?? '';
      deskripsiController.text = penyakitData['Deskripsi'] ?? '';
      obatController.text = penyakitData['Obat'] ?? '';
    });
  }

  void _deletePenyakit(int index) {
    setState(() {
      penyakitList.removeAt(index);
      _clearControllers();
    });
  }
}
