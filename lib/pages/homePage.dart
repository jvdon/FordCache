import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  int curIndex = 0;
  List<Widget> pages = [HomePage()];

  @override
  Widget build(BuildContext context) {
    List<QRCode> posts = user!.getPosts();
    print(posts.length);

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        QRCode qrCode = posts[index];
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
