import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;

  const CustomInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            fillColor: const Color.fromRGBO(42, 107, 172, 0.8),
            constraints: BoxConstraints(maxWidth: 300),
            contentPadding: EdgeInsets.all(20),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Colors.deepPurple),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            label: Text(
              hintText,
              style: TextStyle(color: Colors.white.withOpacity(0.75)),
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
