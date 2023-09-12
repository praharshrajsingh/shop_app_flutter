import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/screens/products_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
              builder: ((context, value, child) => (IconButton(
                    icon: Icon(
                      product.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      product.toggleFavouriteStatus();
                    },
                  )))),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id as String, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Item Added to Cart!'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id as String);
                  },
                  textColor: Colors.purple.shade300,
                ),
              ));
            },
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductsDetailScreen.routeName, arguments: product),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
