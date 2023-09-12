import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  // const OrderItem({super.key});

  final ord.OrderItem orderItem;

  OrderItem({required this.orderItem});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  void expand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.orderItem.productAmount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.orderItem.datetime),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded
                  ? Icons.arrow_drop_up_sharp
                  : Icons.arrow_drop_down_sharp),
              onPressed: () => expand(),
            ),
          ),
          if (_isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: min(widget.orderItem.product.length * 20.0 + 20, 100),
                child: ListView(
                  children: widget.orderItem.product
                      .map((prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${prod.quantity} x', style: TextStyle(fontSize: 18),),
                              Text('${prod.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Divider(),
                              Text('\$${prod.price}', style: TextStyle(fontSize: 18),)
                            ],
                          ))
                      .toList(),
                )),
        ],
      ),
    );
  }
}
