import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  String _lastAddedId;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    int sum = 0;
    if (_items != null && _items.isNotEmpty) {
      _items.forEach((key, value) {
        sum += value.quantity;
      });
    }
    return sum;
  }

  double get itemSum {
    double sum = 0.0;
    if (_items != null && _items.isNotEmpty) {
      _items.forEach((key, value) {
        sum += value.price * value.quantity;
      });
    }
    return double.parse(sum.toStringAsFixed(2));
  }

  void deleteItem(String id) {
    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (item) => CartItem(
                id: item.id,
                title: item.title,
                price: item.price,
                quantity: item.quantity - 1,
              ));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void deleteLastItem() {
    deleteItem(_lastAddedId);
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    _lastAddedId = productId;
    if (_items == null || _items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(id: productId, title: title, price: price, quantity: 1),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
