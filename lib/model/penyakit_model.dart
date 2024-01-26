import 'obat_model.dart';

//DIGUNAKAN UNTUK GET ALL DATA
class PenyakitModel {
  final String id;
  final String jenisPenyakit;
  final String namaPenyakit;
  final String deskripsi;
  final ObatModel obat;

  PenyakitModel({
    required this.id,
    required this.jenisPenyakit,
    required this.namaPenyakit,
    required this.deskripsi,
    required String namaObat,
  }) : obat = ObatModel(
          id: "",
          jenisObat: "",
          namaObat: namaObat,
          deskripsi: "",
          gambar: "",
        );

  factory PenyakitModel.fromJson(Map<String, dynamic> json) => PenyakitModel(
        id: json["_id"],
        jenisPenyakit: json["jenis_penyakit"],
        namaPenyakit: json["nama_penyakit"],
        deskripsi: json["deskripsi"],
        namaObat: json["obat"]["nama_obat"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "jenis_penyakit": jenisPenyakit,
        "nama_penyakit": namaPenyakit,
        "deskripsi": deskripsi,
        "obat": obat.toJson(),
      };
}

//DIGUNAKAN UNTUK FORM INPUT
class PenyakitInput {
  final String jenisPenyakit;
  final String namaPenyakit;
  final String deskripsi;
  final ObatInput obat;

  PenyakitInput({
    required this.jenisPenyakit,
    required this.namaPenyakit,
    required this.deskripsi,
    required String namaObat,
  }) : obat = ObatInput(
          jenisObat: "",
          namaObat: namaObat,
          deskripsi: "",
          imagePath: "",
          imageName: "",
        );

  Map<String, dynamic> toJson() => {
        "jenis_penyakit": jenisPenyakit,
        "nama_penyakit": namaPenyakit,
        "deskripsi": deskripsi,
        "obat": obat.formData(),
      };
}

//DIGUNAKAN UNTUK RESPONSE
class PenyakitResponse {
  final String? insertedId;
  final String message;
  final int status;

  PenyakitResponse({
    this.insertedId,
    required this.message,
    required this.status,
  });

  factory PenyakitResponse.fromJson(Map<String, dynamic> json) =>
      PenyakitResponse(
        insertedId: json["inserted_id"],
        message: json["message"],
        status: json["status"],
      );
}
