import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/carts_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  All,
  Favourites,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context);
    var scaffold = Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          title: const Text(
            'My Shop',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: [
            Consumer<Cart>(
              builder: (_, value, ch) => Badge(
                value: cart.itemCount.toString(),
                child: ch as Widget,
              ), 
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: (){Navigator.of(context).pushNamed(CartsScreen.routeName);},
                ),
            ),
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Only Favourites,'),
                    value: FilterOptions.Favourites),
                PopupMenuItem(
                    child: Text('Show All'), value: FilterOptions.All),
              ],
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (value) {
                setState(() {
                  if (value == FilterOptions.Favourites) {
                    _showFavourites = true;
                  } else {
                    _showFavourites = false;
                  }
                });
              },
            ),
          ],
          backgroundColor: Theme.of(context).primaryColorDark,
        ),
        drawer: AppDrawer(),
        drawerScrimColor: Colors.black87,
        body: ProductsGrid(
          showFavourites: _showFavourites,
        ));
    return scaffold;
  }
}
