import 'package:flutter/material.dart';
import 'package:flutter_obat/model/rs_model.dart';
import 'package:flutter_obat/service/api_rs.dart';
import 'package:flutter_obat/view/widget/rs_card.dart';
import 'package:file_picker/file_picker.dart';

class RSScreen extends StatefulWidget {
  const RSScreen({super.key});

  @override
  State<RSScreen> createState() => _RSScreenState();
}

class _RSScreenState extends State<RSScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaRS = TextEditingController();
  final _noTelp = TextEditingController();
  final _alamat = TextEditingController();
  final _lat = TextEditingController();
  final _long = TextEditingController();
  String _result = '-';

  PlatformFile? file;
  String? _namaFile;
  String? _pathFile;

  final ApiRS _dataService = ApiRS();
  List<RSModel> _rsModel = [];

  RSResponse? rsRes;

  bool isEdit = false;
  String idRS = '';

  @override
  void dispose() {
    _namaRS.dispose();
    _noTelp.dispose();
    _alamat.dispose();
    _lat.dispose();
    _long.dispose();
    super.dispose();
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

  Future<void> refreshRSList() async {
    final users = await _dataService.getAllRS();
    setState(() {
      if (_rsModel.isNotEmpty) _rsModel.clear();
      if (users != null) _rsModel.addAll(users);
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
                controller: _namaRS,
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
                  labelText: 'Nama RS',
                  hintText: 'Masukkan Nama RS',
                  suffixIcon: _namaRS.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _namaRS.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _noTelp,
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'No. Telp',
                  hintText: 'Masukkan No. Telp',
                  suffixIcon: _noTelp.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _noTelp.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _alamat,
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
                  labelText: 'Alamat',
                  hintText: 'Masukkan Alamat',
                  suffixIcon: _alamat.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _alamat.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: TextField(
                        controller: _lat,
                        onChanged: (value) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          labelText: 'Latitude',
                          hintText: 'Masukkan Latitude',
                          suffixIcon: _lat.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _lat.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _long,
                        onChanged: (value) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          labelText: 'Longitude',
                          hintText: 'Masukkan Longitude',
                          suffixIcon: _long.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _long.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
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
                          if (_namaRS.text.isEmpty ||
                              _noTelp.text.isEmpty ||
                              _alamat.text.isEmpty ||
                              _lat.text.isEmpty ||
                              _long.text.isEmpty) {
                            displaySnackbar('Semua field harus diisi');
                            return;
                          }
                          final postModel = RSInput(
                            namaRS: _namaRS.text,
                            noTelp: _noTelp.text,
                            alamat: _alamat.text,
                            latitude: _lat.text,
                            longitude: _long.text,
                            imagePath: _pathFile!,
                            imageName: _namaFile!,
                          );
                          RSResponse? res;
                          if (isEdit) {
                            res = await _dataService.putRS(idRS, postModel);
                          } else {
                            res = await _dataService.postRS(postModel);
                          }

                          setState(() {
                            rsRes = res;
                            isEdit = false;
                          });
                          _namaRS.clear();
                          _noTelp.clear();
                          _alamat.clear();
                          _lat.clear();
                          _long.clear();
                          await refreshRSList();
                        },
                        child: Text(isEdit ? 'UPDATE' : 'POST'),
                      ),
                      if (isEdit)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            _namaRS.clear();
                            _noTelp.clear();
                            _alamat.clear();
                            setState(() {
                              isEdit = false;
                            });
                          },
                          child: const Text('Cancel Update'),
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
                          await refreshRSList();
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
                          _rsModel.clear();
                          rsRes = null;
                        });
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'List RS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _rsModel.isEmpty ? Text(_result) : _buildListRS(),
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
        labelText: 'Gambar RS',
        hintText: 'Masukkan gambar RS',
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

  Widget _buildListRS() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final rsList = _rsModel[index];
          return Card(
            child: ListTile(
// leading: Text(user.id),
              title: Text(rsList.namaRS),
              // subtitle: Text(rsList.noTelp),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      final rss = await _dataService.getSingleRS(rsList.id);
                      setState(() {
                        if (rss != null) {
                          _namaRS.text = rss.namaRS;
                          _noTelp.text = rss.noTelp;
                          _alamat.text = rss.alamat;
                          _lat.text = rss.latitude;
                          _long.text = rss.longitude;
                          isEdit = true;
                          idRS = rss.id;
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(rsList.id, rsList.namaRS);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemCount: _rsModel.length);
  }

  Widget hasilCard(BuildContext context) {
    return Column(children: [
      if (rsRes != null)
        RSCard(
          rsRes: rsRes!,
          onDismissed: () {
            setState(() {
              rsRes = null;
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
                RSResponse? res = await _dataService.deleteRS(id);
                setState(() {
                  rsRes = res;
                });
                Navigator.of(context).pop();
                await refreshRSList();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}
