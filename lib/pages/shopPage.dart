import 'package:flutter/material.dart';
import 'package:sprint_ford/classes/product.dart';
import 'package:sprint_ford/main.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Product> produtos = [
    Product(id: 1, name: "Tire", desc: "Car tire", cost: 120),
    Product(id: 2, name: "Tire", desc: "Car tire", cost: 120),
    Product(id: 3, name: "Tire", desc: "Car tire", cost: 120),
    Product(id: 4, name: "Tire", desc: "Car tire", cost: 120),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          Product product = produtos[index];
          return Column(
            children: [
              ListTile(
                leading: Image(
                  image: product.image,
                  width: 75,
                  fit: BoxFit.fill,
                ),
                title: Text(product.name),
                subtitle: Text(product.desc),
                trailing: Text(product.cost.toString()),
                hoverColor: Colors.black26,
                onTap: () {
                  print(product.id);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
