class ModelDeleteMahasiswadiDosen {
  String message;

  ModelDeleteMahasiswadiDosen({
    required this.message,
  });

  factory ModelDeleteMahasiswadiDosen.fromJson(Map<String, dynamic> json) =>
      ModelDeleteMahasiswadiDosen(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
