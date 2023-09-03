import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sprint_ford/classes/qrcode.dart';
import 'package:sprint_ford/classes/user.dart';
import 'package:sprint_ford/main.dart';
import 'package:sprint_ford/partials/customButton.dart';
import 'package:sprint_ford/partials/customInput.dart';

import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  void signup(String username, String password) async {
    bool ok = false;

    try {
      // http.Response req = await http.post(Uri.parse("http://localhost:8000"),
      //     body:
      //         "username=$username&password=${base64.encode(utf8.encode(password))}");
      // print(req.body);

      User user = User(
        userId: 0,
        username: "jvdon",
        email: "joaov@gmail.com",
        session: "0x01234",
      );

      var myBox = Hive.box("session");

      myBox.put("user", user.toMap());

      ok = true;
    } catch (e) {
      print(e);
      ok = false;
    }

    setState(() {
      if (ok) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return MyApp();
          },
        ));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              (ok == true) ? "Logged in successfully" : "Unable to login")));
    });
  }

  String result = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  foregroundImage: AssetImage("assets/images/logo.png"),
                  radius: 160,
                ),
                Text(
                  "Ford Cache",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomInput(
                    controller: usernameController,
                    hintText: "USERNAME",
                    obscure: false),
                CustomInput(
                    controller: passwordController,
                    hintText: "PASSWORD",
                    obscure: true),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  height: 100,
                  child: CustomButton(
                    text: "Signup",
                    textSize: 32,
                    cb: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
