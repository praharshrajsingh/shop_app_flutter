import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  // final OrdersScreen({super.key});
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders'),),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: ((context, index) =>
            OrderItem(orderItem: orderData.orders[index])),
      ),
    );
  }
}
