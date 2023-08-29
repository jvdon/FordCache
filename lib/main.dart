import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sprint_ford/classes/user.dart';
import 'package:sprint_ford/pages/homePage.dart';
import 'package:sprint_ford/pages/login/loginPage.dart';

void main() async {
  Hive.init(Directory.systemTemp.path);
  await Hive.openBox("session");

  runApp(const MyApp());
}

late User? user = null;

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

  int curIndex = 0;
  List<Widget> pages = [HomePage()];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(17, 43, 78, 1),
        primarySwatch: Colors.deepPurple,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Colors.black45,
          selectedItemColor: Colors.deepPurple,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: (user == null)
          ? LoginPage()
          : Scaffold(
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
                      label: "Post"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 24,
                      ),
                      label: "Shop"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 24,
                      ),
                      label: "Perfil"),
                ],
              ),
            ),
    );
  }
}
