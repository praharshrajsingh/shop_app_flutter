import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class ProductsDetailScreen extends StatelessWidget {
  const ProductsDetailScreen({super.key});

  static const routeName = '/products-details';

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(10),
            child: Text(
              '\$${product.price}',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '${product.description}',
              style: TextStyle(color: Colors.grey, fontSize: 18),
              softWrap: true,
            ),
          )
        ]),
      ),
    );
  }
}
