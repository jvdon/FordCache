import 'package:FordCache/classes/user.dart';

import 'package:latlong2/latlong.dart';

class QRCode {
  int id;
  User user;
  String tile;
  String data;
  LatLng location;

  QRCode(
      {required this.id,
      required this.user,
      required this.tile,
      required this.data,
      required this.location});
}
