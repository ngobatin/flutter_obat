//DIGUNAKAN UNTUK GET ALL DATA
class RSModel {
  final String id;
  final String namaRS;
  final String noTelp;
  final String alamat;
  final String latitude;
  final String longitude;

  RSModel({
    required this.id,
    required this.namaRS,
    required this.noTelp,
    required this.alamat,
    required this.latitude,
    required this.longitude,
  });

  factory RSModel.fromJson(Map<String, dynamic> json) => RSModel(
        id: json["_id"],
        namaRS: json["nama_rs"],
        noTelp: json["no_telp"],
        alamat: json["alamat"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama_rs": namaRS,
        "no_telp": noTelp,
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
      };
}

//DIGUNAKAN UNTUK FORM INPUT
class RSInput {
  final String namaRS;
  final String noTelp;
  final String alamat;
  final String latitude;
  final String longitude;

  RSInput({
    required this.namaRS,
    required this.noTelp,
    required this.alamat,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
        "nama_rs": namaRS,
        "no_telp": noTelp,
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class RSResponse {
  final String? insertedId;
  final String message;
  final int status;

  RSResponse({
    this.insertedId,
    required this.message,
    required this.status,
  });

  factory RSResponse.fromJson(Map<String, dynamic> json) => RSResponse(
        insertedId: json["inserted_id"],
        message: json["message"],
        status: json["status"],
      );
}
