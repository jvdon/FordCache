import 'package:flutter/material.dart';

class Product {
  late int id;
  late String name;
  late String desc;
  late int cost;
  late ImageProvider image;

  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.cost,
    this.image = const AssetImage("assets/images/default_product.png")
  });

  Product.fromJSON();
}