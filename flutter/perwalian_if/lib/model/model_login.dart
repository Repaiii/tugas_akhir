class ModelLogin {
  Data data;
  String message;

  ModelLogin({
    required this.data,
    required this.message,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  int idPengguna;
  dynamic idMahasiswa;
  dynamic idDosen;
  String username;
  dynamic role;
  dynamic namaMahasiswa;
  dynamic namaDosen;
  dynamic namaAdmin;
  dynamic nip;
  dynamic ips;
  dynamic ipk;
  dynamic sk2Pm;
  dynamic fotoMahasiswa;
  dynamic fotoDosen;

  Data({
    required this.idPengguna,
    required this.idMahasiswa,
    required this.idDosen,
    required this.username,
    required this.role,
    required this.namaMahasiswa,
    required this.namaDosen,
    required this.namaAdmin,
    required this.ips,
    required this.ipk,
    required this.sk2Pm,
    required this.fotoMahasiswa,
    required this.fotoDosen,
    required this.nip,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPengguna: json["id_pengguna"],
        idMahasiswa: json["id_mahasiswa"],
        idDosen: json["id_dosen"],
        username: json["username"],
        role: json["role"],
        namaMahasiswa: json["nama_mahasiswa"],
        namaDosen: json["nama_dosen"],
        namaAdmin: json["nama_admin"],
        ips: json["ips"],
        ipk: json["ipk"],
        sk2Pm: json["sk2pm"],
        fotoMahasiswa: json["foto_mahasiswa"],
        fotoDosen: json["foto_dosen"],
        nip: json["nip"],
      );

  Map<String, dynamic> toJson() => {
        "id_pengguna": idPengguna,
        "id_mahasiswa": idMahasiswa,
        "id_dosen": idDosen,
        "username": username,
        "role": role,
        "nama_mahasiswa": namaMahasiswa,
        "nama_dosen": namaDosen,
        "nama_admin": namaAdmin,
        "ips": ips,
        "ipk": ipk,
        "sk2pm": sk2Pm,
        "foto_mahasiswa": fotoMahasiswa,
      };
}
