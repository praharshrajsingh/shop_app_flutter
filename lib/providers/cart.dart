import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              id: productId,
              name: title,
              price: price,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              name: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void empty() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingItem) => CartItem(
                id: existingItem.id,
                name: existingItem.name,
                quantity: existingItem.quantity - 1,
                price: existingItem.price,
              ));
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String key) {
    _items.remove(key);
    notifyListeners();
  }
}
