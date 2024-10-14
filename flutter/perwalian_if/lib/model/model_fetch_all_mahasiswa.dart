class ModelFetchAllMahasiswa {
  List<Datum> data;

  ModelFetchAllMahasiswa({
    required this.data,
  });

  factory ModelFetchAllMahasiswa.fromJson(Map<String, dynamic> json) =>
      ModelFetchAllMahasiswa(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int idMahasiswa;
  String nama;
  String nim;
  double ips;
  double ipk;
  int sk2Pm;
  String pembayaranUkt;
  int semester;
  dynamic fotoMahasiswa;
  String status;
  dynamic idDosen;
  int idPengguna;

  Datum({
    required this.idMahasiswa,
    required this.nama,
    required this.nim,
    required this.ips,
    required this.ipk,
    required this.sk2Pm,
    required this.pembayaranUkt,
    required this.semester,
    required this.fotoMahasiswa,
    required this.status,
    required this.idDosen,
    required this.idPengguna,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idMahasiswa: json["id_mahasiswa"],
        nama: json["nama"],
        nim: json["nim"],
        ips: json["ips"]?.toDouble(),
        ipk: json["ipk"]?.toDouble(),
        sk2Pm: json["sk2pm"],
        pembayaranUkt: json["pembayaran_ukt"],
        semester: json["semester"],
        fotoMahasiswa: json["foto_mahasiswa"],
        status: json["status"],
        idDosen: json["id_dosen"],
        idPengguna: json["id_pengguna"],
      );

  Map<String, dynamic> toJson() => {
         "id_mahasiswa": idMahasiswa,
        "nama": nama,
        "nim": nim,
        "ips": ips,
        "ipk": ipk,
        "sk2pm": sk2Pm,
        "pembayaran_ukt": pembayaranUkt,
        "semester": semester,
        "foto_mahasiswa": fotoMahasiswa,
        "status": status,
        "id_dosen": idDosen,
        "id_pengguna": idPengguna,
      };
}
