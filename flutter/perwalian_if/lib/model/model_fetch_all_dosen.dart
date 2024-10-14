class ModelFetchAllDosen {
  List<Datum> data;

  ModelFetchAllDosen({
    required this.data,
  });

  factory ModelFetchAllDosen.fromJson(Map<String, dynamic> json) =>
      ModelFetchAllDosen(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int idDosen;
  String namaDosen;
  String nip;
  dynamic fotoDosen;
  int idPengguna;

  Datum({
    required this.idDosen,
    required this.namaDosen,
    required this.nip,
    required this.fotoDosen,
    required this.idPengguna,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        nip: json["nip"],
        fotoDosen: json["foto_dosen"],
        idPengguna: json["id_pengguna"],
      );

  Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "nip": nip,
        "foto_dosen": fotoDosen,
        "id_pengguna": idPengguna,
      };
}
