import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final showFavourites;

  ProductsGrid({
    required this.showFavourites,
  });

  // const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Products>(context);
    var products = showFavourites ? provider.favouriteItems : provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: ((context, i) => ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(
              id: products[i].id as String,
              title: products[i].title,
              imageUrl: products[i].imageUrl,
            ),
          )),
    );
  }
}
