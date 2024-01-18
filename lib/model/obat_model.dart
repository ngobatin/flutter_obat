//DIGUNAKAN UNTUK GET ALL DATA
class ObatModel {
  final String id;
  final String jenisObat;
  final String namaObat;
  final String deskripsi;
  final String gambar;

  ObatModel({
    required this.id,
    required this.jenisObat,
    required this.namaObat,
    required this.deskripsi,
    required this.gambar,
  });

  factory ObatModel.fromJson(Map<String, dynamic> json) => ObatModel(
        id: json["_id"],
        jenisObat: json["jenis_obat"],
        namaObat: json["nama_obat"],
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "jenis_obat": jenisObat,
        "nama_obat": namaObat,
        "deskripsi": deskripsi,
        "gambar": gambar,
      };
}

//DIGUNAKAN UNTUK FORM INPUT
class ObatInput {
  final String jenisObat;
  final String namaObat;
  final String deskripsi;
  final String gambar;

  ObatInput({
    required this.jenisObat,
    required this.namaObat,
    required this.deskripsi,
    required this.gambar,
  });

  Map<String, dynamic> toJson() => {
        "jenis_obat": jenisObat,
        "nama_obat": namaObat,
        "deskripsi": deskripsi,
        "gambar": gambar,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class ObatResponse {
  final String? insertedId;
  final String message;
  final int status;

  ObatResponse({
    this.insertedId,
    required this.message,
    required this.status,
  });

  factory ObatResponse.fromJson(Map<String, dynamic> json) => ObatResponse(
        insertedId: json["inserted_id"],
        message: json["message"],
        status: json["status"],
      );
}
