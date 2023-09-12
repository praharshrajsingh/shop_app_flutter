import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  // const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          backgroundColor: Colors.grey.shade800,
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hello!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(Icons.shop, color: Colors.purple,),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.purple),
            title: Text('Orders'),
            onTap: () => Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(Icons.cable_outlined, color: Colors.purple),
            title: Text('Products'),
            onTap: () => Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName),
          ),
        ),
      ]),
    );
  }
}
