
class ModelDeleteDosen {
    String message;

    ModelDeleteDosen({
        required this.message,
    });

    factory ModelDeleteDosen.fromJson(Map<String, dynamic> json) => ModelDeleteDosen(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
