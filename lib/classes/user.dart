import 'package:FordCache/classes/qrcode.dart';

import 'package:latlong2/latlong.dart';

class User {
  late int userId;
  late String username;
  late String email;
  late String session;
  late String profilePicture;
  late String bannerPicture;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.session,
    this.profilePicture = "assets/images/default_user.png",
    this.bannerPicture = "assets/images/default_banner.png",
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = Map();
    res["userId"] = this.userId;
    res["username"] = this.username;
    res["email"] = this.email;
    res["session"] = this.session;
    res["profilePicture"] = this.profilePicture;
    res["bannerPicture"] = this.bannerPicture;

    return res;
  }

  User.fromMap(Map<dynamic, dynamic> data) {
    this.userId = data["userId"];
    this.username = data["username"];
    this.email = data["email"];
    this.session = data["session"];
    this.profilePicture = data["profilePicture"];
    this.bannerPicture = data["bannerPicture"];
  }

  List<QRCode> getCodes() {
    return [
      QRCode(
          id: 1,
          tile: "tile",
          user: this,
          data: "12/05/01",
          location: LatLng(10, 20)),
      QRCode(
          id: 2,
          tile: "tile",
          user: this,
          data: "12/05/02",
          location: LatLng(20, 30)),
      QRCode(
          id: 3,
          tile: "tile",
          user: this,
          data: "12/05/03",
          location: LatLng(30, 40)),
      QRCode(
          id: 4,
          tile: "tile",
          user: this,
          data: "12/05/04",
          location: LatLng(40, 50)),
    ];
  }
}
