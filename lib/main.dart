import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sprint_ford/classes/user.dart';
import 'package:sprint_ford/pages/homePage.dart';
import 'package:sprint_ford/pages/login/loginPage.dart';
import 'package:sprint_ford/pages/mapPage.dart';
import 'package:sprint_ford/pages/profilePage.dart';
import 'package:sprint_ford/pages/scanPage.dart';

void main() async {
  Hive.init(Directory.systemTemp.path);
  await Hive.openBox("session");

  runApp(const MyApp());
}

late User? user = null;
Color bgColor = Color.fromRGBO(17, 43, 78, 1);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        appBarTheme: AppBarTheme(
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: bgColor,
        ),
        primarySwatch: Colors.deepPurple,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Colors.black45,
          selectedItemColor: Colors.deepPurple,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: (user == null) ? const LoginPage() : App(),
    );
  }
}

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int curIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const MapPage(),
    const ScanPage(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: const Row(
                children: [
                  CircleAvatar(
                    foregroundImage: AssetImage("assets/images/logo.png"),
                    radius: 20,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Ford Cache",
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: bgColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: bgColor,
                        image: DecorationImage(
                            image: AssetImage(user!.bannerPicture),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.contain),
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                        child: ListTile(
                          style: ListTileStyle.list,
                          leading: CircleAvatar(
                            foregroundImage: AssetImage(user!.profilePicture),
                          ),
                          title: Text(user!.username),
                          subtitle: Text(user!.email),
                          trailing: Text(user!.points.toString()),
                        ),
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                foregroundImage: AssetImage(user!.profilePicture),
              ),
            ),
          ],
        ),
      ),
      body: pages[curIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curIndex,
        onTap: (value) => setState(() {
          curIndex = value;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                size: 24,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
                size: 24,
              ),
              label: "Por Perto"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                size: 24,
              ),
              label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 24,
              ),
              label: "Shop"),
        ],
      ),
    );
  }
}
