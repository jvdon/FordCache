import 'package:sprint_ford/classes/user.dart';

import 'package:latlong2/latlong.dart';

class QRCode {
  int id;
  User user;
  String tile;
  int points;
  String data;
  LatLng location;

  QRCode(
      {required this.id,
      required this.user,
      required this.tile,
      required this.points,
      required this.data,
      required this.location});
}
