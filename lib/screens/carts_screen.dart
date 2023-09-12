import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartsScreen extends StatelessWidget {
  static const routeName = '/cart';

  // const CartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('\$${cart.totalAmount}'),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount.toInt(),
                      );
                      cart.empty();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ]),
          ),
          elevation: 6,
          shadowColor: Colors.grey.shade100,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) => CartItem(
                  cart.items.values.toList()[index].id,
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].price,
                  cart.items.values.toList()[index].quantity,
                  cart.items.values.toList()[index].name,
                )),
            itemCount: cart.itemCount,
          ),
        )
      ]),
    );
  }
}
