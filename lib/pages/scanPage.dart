import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sprint_ford/classes/user.dart';
import 'package:sprint_ford/partials/customButton.dart';

import 'package:sprint_ford/classes/conf.dart' as conf;



import 'package:http/http.dart' as http;

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
late User? user;

class _ScanPageState extends State<ScanPage> {
  Widget result = Text("Escaneie um QRCode para ganhar pontos!");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final box = Hive.box("session");

    final userMap = box.get("user");
    user = (userMap != null) ? User.fromMap(userMap) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Center(
              child: result,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 250,
              child: CustomButton(
                text: "Scan",
                textSize: 32,
                cb: () {
                  scanQR();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    var myBox = Hive.box("session");
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      http.Response res = await http.get(Uri.parse(
          "${conf.backUrl ?? "http://localhost:5000"}/rewards?code=$barcodeScanRes&userId=${user!.userId}"));

      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        User user = User.fromMap(resJson);

        myBox.put("user", user.toMap());
      }
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = "";
      // barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes.isNotEmpty) {
        result = QrImageView(data: barcodeScanRes, backgroundColor: Colors.white,);
      }
    });

    await Future.delayed(Duration(seconds: 2));
    
  }
}
