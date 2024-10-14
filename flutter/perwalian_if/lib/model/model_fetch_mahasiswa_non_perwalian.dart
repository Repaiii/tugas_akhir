
class ModelNonPerwalian {
    List<Datum> data;

    ModelNonPerwalian({
        required this.data,
    });

    factory ModelNonPerwalian.fromJson(Map<String, dynamic> json) => ModelNonPerwalian(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int idMahasiswa;
    String nama;
    String? nim;
    double ips;
    double ipk;
    int sk2Pm;
    PembayaranUkt pembayaranUkt;
    int semester;
    dynamic fotoMahasiswa;
    Status? status;
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
        pembayaranUkt: pembayaranUktValues.map[json["pembayaran_ukt"]]!,
        semester: json["semester"],
        fotoMahasiswa: json["foto_mahasiswa"],
        status: statusValues.map[json["status"]],
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
        "pembayaran_ukt": pembayaranUktValues.reverse[pembayaranUkt],
        "semester": semester,
        "foto_mahasiswa": fotoMahasiswa,
        "status": statusValues.reverse[status],
        "id_dosen": idDosen,
        "id_pengguna": idPengguna,
    };
}

enum PembayaranUkt {
    BELUM_BAYAR,
    SUDAH_BAYAR
}

final pembayaranUktValues = EnumValues({
    "Belum Bayar": PembayaranUkt.BELUM_BAYAR,
    "Sudah Bayar": PembayaranUkt.SUDAH_BAYAR
});

enum Status {
    AMAN,
    BAHAYA,
    SEDANG
}

final statusValues = EnumValues({
    "Aman": Status.AMAN,
    "Bahaya": Status.BAHAYA,
    "Sedang": Status.SEDANG
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
