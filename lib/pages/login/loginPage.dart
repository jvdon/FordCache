import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:sprint_ford/classes/user.dart';
import 'package:sprint_ford/main.dart';
import 'package:sprint_ford/partials/customInput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool login(String username, String password) {
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

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              onPressed: () {
                print(
                    "${usernameController.text} - ${passwordController.text}");
                bool res =
                    login(usernameController.text, passwordController.text);
                setState(() {
                  if (res) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return MyApp();
                      },
                    ));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text((res == true)
                          ? "Logged in successfully"
                          : "Unable to login")));
                });
              },
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
