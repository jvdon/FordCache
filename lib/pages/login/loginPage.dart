import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:sprint_ford/classes/user.dart';
import 'package:sprint_ford/main.dart';
import 'package:sprint_ford/pages/login/signupPage.dart';
import 'package:sprint_ford/partials/customButton.dart';
import 'package:sprint_ford/partials/customInput.dart';

import 'package:sprint_ford/classes/conf.dart' as conf;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void login(String username, String password) async {
    bool ok = false;

    try {
      http.Response req = await http.post(
        Uri.parse("${conf.backUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            <String, String>{"username": username, "password": password}),
      );

      if (req.statusCode == 200) {
        var myBox = Hive.box("session");
        var resJson = json.decode(req.body);
        User user = User.fromMap(resJson);

        myBox.put("user", user.toMap());

        ok = true;
      }
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
                  radius: 80,
                ),
                Text(
                  "Ford Cache",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 50,
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
                  width: 200,
                  height: 100,
                  child: CustomButton(
                    text: "Login",
                    textSize: 36,
                    cb: () {
                      login(usernameController.text, passwordController.text);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: CustomButton(
                    text: "Signup",
                    cb: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return SignupPage();
                          },
                        ),
                      );
                    },
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
