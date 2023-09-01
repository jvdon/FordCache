import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hive/hive.dart';

import 'package:latlong2/latlong.dart';
import 'package:FordCache/classes/qrcode.dart';
import 'package:FordCache/classes/user.dart';

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
    // TODO: implement initState
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${qrcode.location.latitude}° - ${qrcode.location.longitude}°  ${qrcode.data}")));
            },
            child: Icon(Icons.qr_code_2),
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(qrcodes.length);
    return FlutterMap(
      options: MapOptions(
          center: const LatLng(-14.2400732, -53.1805017),
          zoom: 8,
          maxBounds: LatLngBounds(
            const LatLng(-90, -180),
            const LatLng(90, 180),
          )),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.zeyk.Gs',
        ),
        MarkerLayer(
          markers: markers,
        )
      ],
    );
  }
}
