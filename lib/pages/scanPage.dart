import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sprint_ford/partials/customButton.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

class _ScanPageState extends State<ScanPage> {
  String _scanBarcode = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Center(
              child: Text(
                (_scanBarcode.isEmpty)
                    ? "Escaneie um QRCode para ganhar pontos!"
                    : _scanBarcode,
              ),
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
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}
