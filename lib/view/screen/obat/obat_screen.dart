import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_obat/model/obat_model.dart';
import 'package:flutter_obat/service/api_obat.dart';
import 'package:flutter_obat/view/widget/obat_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ObatScreen extends StatefulWidget {
  const ObatScreen({super.key});

  @override
  State<ObatScreen> createState() => _ObatScreenState();
}

class _ObatScreenState extends State<ObatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaObat = TextEditingController();
  final _jenisObat = TextEditingController();
  final _deskripsi = TextEditingController();
  String _result = '-';

  PlatformFile? file;
  String? _namaFile;
  String? _pathFile;
  bool _gambarTerisi = false;

  final ApiObat _dataService = ApiObat();
  List<ObatModel> _obatModel = [];

  ObatResponse? obatRes;

  bool isEdit = false;
  String idObat = '';

  @override
  void dispose() {
    _namaObat.dispose();
    _jenisObat.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  bool _validateFile(String? pathFile) {
    if (pathFile == null) {
      return true;
    }
    return false;
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    file = result.files.single;

    setState(() {
      _namaFile = file!.name;
      _pathFile = file!.path;
    });
  }

  Future<void> refreshObatList() async {
    final users = await _dataService.getAllObat();
    setState(() {
      if (_obatModel.isNotEmpty) _obatModel.clear();
      if (users != null) _obatModel.addAll(users);
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
        // centerTitle: true,
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              TextField(
                controller: _jenisObat,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Jenis Obat',
                  hintText: 'Masukkan jenis obat',
                  suffixIcon: IconButton(
                    onPressed: _jenisObat.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _namaObat,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Nama Obat',
                  hintText: 'Masukkan nama obat',
                  suffixIcon: IconButton(
                    onPressed: _namaObat.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _deskripsi,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi obat',
                  suffixIcon: IconButton(
                    onPressed: _deskripsi.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              buildFilePicker(context),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_namaObat.text.isEmpty ||
                              _jenisObat.text.isEmpty ||
                              _deskripsi.text.isEmpty) {
                            displaySnackbar('Semua field harus diisi');
                            return;
                          }
                          final postModel = ObatInput(
                            jenisObat: _jenisObat.text,
                            namaObat: _namaObat.text,
                            deskripsi: _deskripsi.text,
                            imagePath: _pathFile!,
                            imageName: _namaFile!,
                          );
                          ObatResponse? res;
                          if (isEdit) {
                            res = await _dataService.putObat(idObat, postModel);
                          } else {
                            res = await _dataService.postObat(postModel);
                          }

                          setState(() {
                            obatRes = res;
                            isEdit = false;
                          });
                          _namaObat.clear();
                          _jenisObat.clear();
                          _deskripsi.clear();
                          await refreshObatList();
                        },
                        child: Text(isEdit ? 'UPDATE' : 'POST'),
                      ),
                      if (isEdit)
                        ElevatedButton(
                          onPressed: () {
                            _namaObat.clear();
                            _jenisObat.clear();
                            _deskripsi.clear();
                            setState(() {
                              isEdit = false;
                            });
                          },
                          child: const Text('Cancel Update',
                              style: TextStyle(color: Colors.red)),
                        ),
                    ],
                  )
                ],
              ),
              hasilCard(context),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await refreshObatList();
                        setState(() {});
                      },
                      child: const Text('Refresh Data'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _result = '-';
                        _obatModel.clear();
                        obatRes = null;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'List Obat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _obatModel.isEmpty ? Text(_result) : _buildListObat(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget buildFilePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (_pathFile != null)
          //   SizedBox(
          //     width: 300,
          //     child: SingleChildScrollView(
          //       child: Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //             width: 1,
          //           ),
          //         ),
          //         child: Column(
          //           children: [
          //             Image.file(
          //               File(_pathFile.toString()),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          const SizedBox(
            height: 5,
          ),
          if (_namaFile != null) Text('File: $_namaFile'),
          if (_gambarTerisi && _namaFile == null)
            const Text(
              'Gambar harus diisi',
              style: TextStyle(color: Color.fromRGBO(212, 50, 50, 1)),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(18, 140, 126, 1),
            )),
            onPressed: () async {
              _pickFile();
            },
            child: const Text(
              'Masukkan Gambar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _buildListObat() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final obatList = _obatModel[index];
          return Card(
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: obatList.gambar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(obatList.namaObat),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      final obats =
                          await _dataService.getSingleObat(obatList.id);
                      setState(() {
                        if (obats != null) {
                          _namaObat.text = obats.namaObat;
                          _jenisObat.text = obats.jenisObat;
                          _deskripsi.text = obats.deskripsi;
                          isEdit = true;
                          idObat = obats.id;
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                          obatList.id, obatList.namaObat);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemCount: _obatModel.length);
  }

  Widget hasilCard(BuildContext context) {
    return Column(children: [
      if (obatRes != null)
        ObatCard(
          obatRes: obatRes!,
          onDismissed: () {
            setState(() {
              obatRes = null;
            });
          },
        )
      else
        const Text(''),
    ]);
  }

  void _showDeleteConfirmationDialog(String id, String nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data $nama ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                ObatResponse? res = await _dataService.deleteObat(id);
                setState(() {
                  obatRes = res;
                });
                Navigator.of(context).pop();
                await refreshObatList();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}
