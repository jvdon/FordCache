import 'dart:convert';

import 'package:sprint_ford/classes/qrcode.dart';
import 'package:http/http.dart' as http;
import 'package:sprint_ford/classes/conf.dart' as conf;

class User {
  late int userId;
  late String username;
  late String email;
  late int points;
  late List codes;
  late String profilePicture;
  late String bannerPicture;

  User({
    required this.userId,
    required this.username,
    required this.email,
    this.codes = const [],
    required this.points,
    this.profilePicture = "assets/images/default_user.png",
    this.bannerPicture = "assets/images/default_banner.png",
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = Map();
    res["userId"] = this.userId;
    res["username"] = this.username;
    res["email"] = this.email;
    res["codes"] = this.codes;
    res["points"] = this.points;
    res["profilePicture"] = this.profilePicture;
    return res;
  }

  User.fromMap(Map<dynamic, dynamic> data) {
    this.userId = data["userId"];
    this.username = data["username"];
    this.email = data["email"];
    this.codes = data["codes"];
    this.points = data["points"];
    this.profilePicture =
        "assets/images/default_user.png"; //data["profilePicture"];
    this.bannerPicture = "assets/images/default_banner.png";
  }

  Future<List<QRCode>> getCodes() async {
    List<QRCode> qrs = [];
    for (var code in codes) {
      http.Response res =
          await http.get(Uri.parse("${conf.backUrl}/qrcodes?code=$code"));
      if (res.statusCode == 200) {
        qrs.add(QRCode.fromJSON(jsonDecode(res.body)));
      }
    }
    return qrs;
  }
}
