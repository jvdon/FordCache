import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:FordCache/classes/qrcode.dart';
import 'package:FordCache/classes/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late User? user;
late List<QRCode> qrcodes = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final box = Hive.box("session");
    final userMap = box.get("user");
    user = (userMap != null) ? User.fromMap(userMap) : null;
    qrcodes = user!.getCodes();
  }

  @override
  Widget build(BuildContext context) {
    print(qrcodes.length);

    return ListView.builder(
      itemCount: qrcodes.length,
      itemBuilder: (context, index) {
        QRCode qrCode = qrcodes[index];
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                  foregroundImage: AssetImage(qrCode.user.profilePicture)),
              title: Text(qrCode.tile),
              subtitle: Text(
                  "${qrCode.location.latitude}° - ${qrCode.location.longitude}°  ${qrCode.data}"),
            )
          ],
        );
      },
    );
  }
}
