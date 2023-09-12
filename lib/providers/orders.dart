import 'package:flutter/cupertino.dart';

import 'cart.dart';
import 'product.dart';

class OrderItem {
  final String id;
  final int productAmount;
  final DateTime datetime;
  final List<CartItem> product;

  OrderItem({
    required this.id,
    required this.productAmount,
    required this.datetime,
    required this.product,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cart, int totalAmount) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          productAmount: totalAmount,
          datetime: DateTime.now(),
          product: cart),
    );
    notifyListeners();
  }
}
