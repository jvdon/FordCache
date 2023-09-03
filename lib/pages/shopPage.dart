import 'package:flutter/material.dart';
import 'package:sprint_ford/classes/product.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Product> produtos = [
    Product(id: 1, name: "Tire", desc: "Car tire", cost: 120)
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3
      ),      
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Product product = produtos[index];
        return Container(
          child: Column(
            children: [
              Image(image: product.image, width: 200, height: 150,),
              ListTile(
                title: Text(product.name),
                subtitle: Text(product.desc),
                trailing: Text(product.cost.toString()),
              )
            ],
          ),
        );
      },
    );
  }
}
