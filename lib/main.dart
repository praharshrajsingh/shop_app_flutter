import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/carts_screen.dart';
import 'package:shop_app/screens/edit_products_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'providers/cart.dart';
import 'providers/products.dart';
import 'screens/products_overview_screen.dart';
import 'providers/orders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.grey,
          accentColor: Colors.purple,
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductsDetailScreen.routeName: (context) {
            return ProductsDetailScreen();
          },
          CartsScreen.routeName: (context) => CartsScreen(),
          OrdersScreen.routeName :(context) => OrdersScreen(),
          UserProductsScreen.routeName : (context)=> UserProductsScreen(),
          EditProductsScreen.routeName :(context) => EditProductsScreen(),
        },
      ),
    );
  }
}