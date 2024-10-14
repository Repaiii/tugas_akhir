class ModelAddPengguna {
  Data data;

  ModelAddPengguna({
    required this.data,
  });

  factory ModelAddPengguna.fromJson(Map<String, dynamic> json) =>
      ModelAddPengguna(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  int idPengguna;
  String username;
  String password;
  String role;

  Data({
    required this.idPengguna,
    required this.username,
    required this.password,
    required this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPengguna: json["id_pengguna"],
        username: json["username"],
        password: json["password"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id_pengguna": idPengguna,
        "username": username,
        "password": password,
        "role": role,
      };
}
