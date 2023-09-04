import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hive/hive.dart';

import 'package:latlong2/latlong.dart';
import 'package:sprint_ford/classes/qrcode.dart';
import 'package:sprint_ford/classes/user.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

late User? user;

class _MapPageState extends State<MapPage> {
  List<QRCode> qrcodes = [];
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();

    final box = Hive.box("session");
    final userMap = box.get("user");

    user = (userMap != null) ? User.fromMap(userMap) : null;

    qrcodes = user!.getCodes();

    for (var qrcode in qrcodes) {
      markers.add(Marker(
        point: qrcode.location,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45))),
                    backgroundColor: const Color.fromRGBO(17, 43, 78, 1),
                    child: ListTile(
                      leading: const Icon(
                        Icons.qr_code,
                        color: Colors.white,
                        size: 32,
                      ),
                      title: Text(qrcode.tile),
                      subtitle: Text(qrcode.data),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.qr_code_2,
              color: Colors.black,
            ),
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: const LatLng(-14.2400732, -53.1805017),
          zoom: 10,
          maxBounds: LatLngBounds(
            const LatLng(-90, -180),
            const LatLng(90, 180),
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.zeyk.Gs',
            // tileBuilder: darkModeTileBuilder,
          ),
          MarkerLayer(
            markers: markers,
          )
        ],
      ),
    );
  }
}
