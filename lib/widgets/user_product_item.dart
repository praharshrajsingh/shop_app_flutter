import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_products_screen.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  // const UserProductItem({super.key});
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(onPressed: (){
            print(id);
            Navigator.of(context).pushNamed(EditProductsScreen.routeName, arguments: id);
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: (){
            Provider.of<Products>(context, listen:false).removeProduct(id);
          }, icon: Icon(Icons.delete), color: Theme.of(context).errorColor,),
        ]),
      ),
    );
  }
}
