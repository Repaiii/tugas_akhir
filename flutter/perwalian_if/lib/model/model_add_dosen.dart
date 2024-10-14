class ModelAddDosen {
  int idDosen;
  String namaDosen;
  String nip;
  String fotoDosen;
  int idPengguna;
  List<dynamic> mahasiswaPerwalian;

  ModelAddDosen({
    required this.idDosen,
    required this.namaDosen,
    required this.nip,
    required this.fotoDosen,
    required this.idPengguna,
    required this.mahasiswaPerwalian,
  });

  factory ModelAddDosen.fromJson(Map<String, dynamic> json) => ModelAddDosen(
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        nip: json["nip"],
        fotoDosen: json["foto_dosen"],
        idPengguna: json["id_pengguna"],
        mahasiswaPerwalian:
            List<dynamic>.from(json["mahasiswa_perwalian"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "nip": nip,
        "foto_dosen": fotoDosen,
        "id_pengguna": idPengguna,
        "mahasiswa_perwalian":
            List<dynamic>.from(mahasiswaPerwalian.map((x) => x)),
      };
}
