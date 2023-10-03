import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sprint_ford/classes/qrcode.dart';
import 'package:sprint_ford/classes/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late User? user;

class _HomePageState extends State<HomePage> {
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
    return FutureBuilder<List<QRCode>>(
      future: user!.getCodes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<QRCode> qrcodes = snapshot.data!;
            return ListView.builder(
              itemCount: qrcodes.length,
              itemBuilder: (context, index) {
                QRCode qrCode = qrcodes[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          foregroundImage: AssetImage(user!.profilePicture)),
                      title: Text(qrCode.title),
                      subtitle: Text(qrCode.data),
                      trailing: Text(qrCode.points.toString()),
                    ),
                    Center(
                      child: QrImageView(
                        data: qrCode.code,
                        size: 200,
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error fetching qrcodes"),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
