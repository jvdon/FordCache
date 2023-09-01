import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:FordCache/classes/qrcode.dart';
import 'package:FordCache/classes/user.dart';
import 'package:FordCache/partials/customInput.dart';

import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Future<bool> signup(String username, String password) async {
    try {
      http.Response req = await http.post(Uri.parse("http://localhost:8000"),
          body:
              "username=$username&password=${base64.encode(utf8.encode(password))}");
      print(req.body);

      User user = User(
        userId: 0,
        username: "jvdon",
        email: "joaov@gmail.com",
        session: "0x01234",
      );

      var myBox = Hive.box("session");

      myBox.put("user", user.toMap());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  String result = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Center(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(result),
            ),
            CustomInput(
                controller: usernameController,
                hintText: "USERNAME",
                obscure: false),
            CustomInput(
                controller: passwordController,
                hintText: "PASSWORD",
                obscure: true),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () async {
                  print(
                      "${usernameController.text} - ${passwordController.text}");
                  bool res = await signup(
                      usernameController.text, passwordController.text);
                  setState(() {
                    result = (res == true)
                        ? "Registered successfully"
                        : "Unable to sign-up";
                  });
                },
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
