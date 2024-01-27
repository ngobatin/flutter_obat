import 'package:flutter/material.dart';
import 'package:flutter_obat/model/penyakit_model.dart';
import 'package:flutter_obat/service/api_penyakit.dart';
import 'package:flutter_obat/service/api_obat.dart';
import 'package:flutter_obat/view/widget/penyakit_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PenyakitScreen extends StatefulWidget {
  const PenyakitScreen({super.key});

  @override
  State<PenyakitScreen> createState() => _PenyakitScreenState();
}

class _PenyakitScreenState extends State<PenyakitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaPenyakit = TextEditingController();
  final _jenisPenyakit = TextEditingController();
  final _deskripsi = TextEditingController();
  // final _namaObat = TextEditingController();
  String _result = '-';
  String? _selectedObat;

  final ApiPenyakit _dataService = ApiPenyakit();
  List<PenyakitModel> _penyakitModel = [];

  PenyakitResponse? penyakitRes;

  bool isEdit = false;
  String idPenyakit = '';

  @override
  void dispose() {
    _namaPenyakit.dispose();
    _jenisPenyakit.dispose();
    _deskripsi.dispose();
    // _namaObat.dispose();
    super.dispose();
  }

  String? _validatePenyakit(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data Tidak boleh kosong';
    }
    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
      return 'Data harus diawali dengan huruf kapital';
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Data hanya boleh mengandung huruf';
    }
    return null;
  }

  String? _validateNamaObat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pilih nama obat';
    }
    return null;
  }

  Future<void> refreshPenyakitList() async {
    final users = await _dataService.getAllPenyakit();
    setState(() {
      if (_penyakitModel.isNotEmpty) _penyakitModel.clear();
      if (users != null) _penyakitModel.addAll(users);
    });
  }

  final ApiObat _dataServices = ApiObat();
  List<String> obatNames = [];

  @override
  void initState() {
    super.initState();
    _getAllObatNames();
  }

  Future<void> _getAllObatNames() async {
    final obats = await _dataServices.getAllObatNames();
    setState(() {
      if (obatNames.isNotEmpty) obatNames.clear();
      if (obats != null) obatNames.addAll(obats);
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
              TextFormField(
                controller: _jenisPenyakit,
                validator: _validatePenyakit,
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
                  labelText: 'Jenis Penyakit',
                  hintText: 'Masukkan jenis penyakit',
                  suffixIcon: _jenisPenyakit.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _jenisPenyakit.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _namaPenyakit,
                validator: _validatePenyakit,
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
                  labelText: 'Nama Penyakit',
                  hintText: 'Masukkan nama penyakit',
                  suffixIcon: _namaPenyakit.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _namaPenyakit.clear();
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
                validator: _validatePenyakit,
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
                  hintText: 'Masukkan deskripsi',
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
              DropdownButtonFormField2<String>(
                value: _selectedObat,
                validator: _validateNamaObat,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedObat = newValue;
                  });
                },
                items: obatNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Nama Obat',
                  hintText: 'Pilih nama obat',
                  suffixIcon: _selectedObat != null
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedObat = null;
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
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
                          if (_namaPenyakit.text.isEmpty ||
                              _jenisPenyakit.text.isEmpty ||
                              _deskripsi.text.isEmpty ||
                              _selectedObat == null) {
                            displaySnackbar('Semua field harus diisi');
                            return;
                          }
                          final postModel = PenyakitInput(
                            jenisPenyakit: _jenisPenyakit.text,
                            namaPenyakit: _namaPenyakit.text,
                            deskripsi: _deskripsi.text,
                            namaObat: _selectedObat!,
                          );
                          PenyakitResponse? res;
                          if (isEdit) {
                            res = await _dataService.putPenyakit(
                                idPenyakit, postModel);
                          } else {
                            res = await _dataService.postPenyakit(postModel);
                          }

                          setState(() {
                            penyakitRes = res;
                            isEdit = false;
                          });
                          _namaPenyakit.clear();
                          _jenisPenyakit.clear();
                          _deskripsi.clear();
                          _selectedObat = null;
                          await refreshPenyakitList();
                        },
                        child: Text(isEdit ? 'UPDATE' : 'POST'),
                      ),
                      if (isEdit)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            _namaPenyakit.clear();
                            _jenisPenyakit.clear();
                            _deskripsi.clear();
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
                          await refreshPenyakitList();
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
                          _penyakitModel.clear();
                          penyakitRes = null;
                        });
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'List Penyakit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _penyakitModel.isEmpty
                    ? Text(_result)
                    : _buildListPenyakit(),
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

  Widget _buildListPenyakit() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final penyakitList = _penyakitModel[index];
          return Card(
            child: ListTile(
// leading: Text(user.id),
              // title: Text(penyakitList.jenisPenyakit),
              title: Text(penyakitList.namaPenyakit),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      final penyakits =
                          await _dataService.getSinglePenyakit(penyakitList.id);
                      setState(() {
                        if (penyakits != null) {
                          _namaPenyakit.text = penyakits.namaPenyakit;
                          _jenisPenyakit.text = penyakits.jenisPenyakit;
                          _deskripsi.text = penyakits.deskripsi;
                          _selectedObat = penyakits.obat.namaObat;
                          isEdit = true;
                          idPenyakit = penyakits.id;
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                          penyakitList.id, penyakitList.namaPenyakit);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemCount: _penyakitModel.length);
  }

  Widget hasilCard(BuildContext context) {
    return Column(children: [
      if (penyakitRes != null)
        PenyakitCard(
          penyakitRes: penyakitRes!,
          onDismissed: () {
            setState(() {
              penyakitRes = null;
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
                PenyakitResponse? res = await _dataService.deletePenyakit(id);
                setState(() {
                  penyakitRes = res;
                });
                Navigator.of(context).pop();
                await refreshPenyakitList();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}
