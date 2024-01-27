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

  String? _validateObat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data tidak boleh kosong';
    }
    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
      return 'Data harus diawali dengan huruf kapital';
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Data hanya boleh mengandung huruf';
    }
    return null;
  }

  // bool _validateFile(String? pathFile) {
  //   if (pathFile == null) {
  //     return true;
  //   }
  //   return false;
  // }

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
        backgroundColor: Colors.orange.shade800,
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
              TextFormField(
                controller: _jenisObat,
                validator: _validateObat,
                onChanged: (value) {
                  setState(() {});
                },
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
                  suffixIcon: _jenisObat.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _jenisObat.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _namaObat,
                validator: _validateObat,
                onChanged: (value) {
                  setState(() {});
                },
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
                  suffixIcon: _namaObat.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _namaObat.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _deskripsi,
                validator: _validateObat,
                maxLines: 3,
                onChanged: (value) {
                  setState(() {});
                },
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
                  suffixIcon: _deskripsi.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _deskripsi.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
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
              Flexible(
                child: Row(
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
    return TextField(
      controller: TextEditingController(text: _namaFile),
      readOnly: true,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        labelText: 'Gambar Obat',
        hintText: 'Masukkan gambar obat',
        suffixIcon: _namaFile != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _namaFile = null;
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: () async {
                  _pickFile();
                },
              ),
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
