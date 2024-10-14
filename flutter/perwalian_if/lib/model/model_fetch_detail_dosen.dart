class ModelFetchDetailDosen {
  int idDosen;
  List<MahasiswaPerwalian> mahasiswaPerwalian;
  String namaDosen;
  String nip;
  String fotoDosen;
  int idPengguna;

  ModelFetchDetailDosen({
    required this.idDosen,
    required this.mahasiswaPerwalian,
    required this.namaDosen,
    required this.nip,
    required this.fotoDosen,
    required this.idPengguna,
  });

  factory ModelFetchDetailDosen.fromJson(Map<String, dynamic> json) =>
      ModelFetchDetailDosen(
        idDosen: json["id_dosen"],
        mahasiswaPerwalian: List<MahasiswaPerwalian>.from(
            json["mahasiswa_perwalian"]
                .map((x) => MahasiswaPerwalian.fromJson(x))),
        namaDosen: json["nama_dosen"],
        nip: json["nip"],
        fotoDosen: json["foto_dosen"],
        idPengguna: json["id_pengguna"],
      );

  Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "mahasiswa_perwalian":
            List<dynamic>.from(mahasiswaPerwalian.map((x) => x.toJson())),
        "nama_dosen": namaDosen,
        "nip": nip,
        "foto_dosen": fotoDosen,
        "id_pengguna": idPengguna,
      };
}

class MahasiswaPerwalian {
  int idMahasiswa;
  String nama;
  String nim;
  double ips;
  double ipk;
  int sk2Pm;
  String pembayaranUkt;
  int semester;
  String fotoMahasiswa;
  String status;
  int idDosen;
  int idPengguna;

  MahasiswaPerwalian({
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

  factory MahasiswaPerwalian.fromJson(Map<String, dynamic> json) =>
      MahasiswaPerwalian(
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
