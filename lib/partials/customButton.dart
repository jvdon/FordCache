import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? cb;
  final String text;
  final int textSize;

  const CustomButton(
      {super.key, required this.text, this.cb, this.textSize = 24});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll<EdgeInsetsDirectional>(
            EdgeInsetsDirectional.all(5)),
        backgroundColor: const MaterialStatePropertyAll<Color>(
            Color.fromRGBO(42, 107, 172, 1)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
        ),
      ),
      onPressed: cb,
      child: Text(text, style: TextStyle(fontSize: textSize.toDouble())),
    );
  }
}
