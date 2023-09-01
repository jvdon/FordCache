import 'package:flutter/material.dart';
import 'package:FordCache/classes/qrcode.dart';

class QRCodeCard extends StatefulWidget {
  final QRCode qrCode;

  const QRCodeCard({
    super.key,
    required this.qrCode,
  });

  @override
  State<QRCodeCard> createState() => _QRCodeCardState();
}

class _QRCodeCardState extends State<QRCodeCard> {
  @override
  Widget build(BuildContext context) {
    QRCode post = this.widget.qrCode;
    return Container(
      height: 200,
      width: 600,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  foregroundImage: AssetImage(post.user.profilePicture)),
              Column(
                children: [
                  Text(post.tile),
                  Text(post.user.username),
                ],
              ),
              Text(post.location.toString())
            ],
          )
        ],
      ),
    );
  }
}
