class QRCode {
  late int id;
  late String title;
  late String code;
  late int points;
  late String data;

  QRCode(
      {required this.id,
      required this.title,
      required this.code,
      required this.points,
      required this.data});

  QRCode.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    code = json["code"];
    points = json["points"];
    data = json["data"];
  }
}
