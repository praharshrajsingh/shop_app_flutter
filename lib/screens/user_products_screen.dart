import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_products_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatefulWidget {
  const UserProductsScreen({super.key});
  static const routeName = '/user-products-screen'; 

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {

  @override
  void didChangeDependencies() {
    setState(() {
      
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(EditProductsScreen.routeName);
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].id as String,
                productsData.items[i].title,
                productsData.items[i].imageUrl,
              ),
              Divider(thickness: 1,),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
