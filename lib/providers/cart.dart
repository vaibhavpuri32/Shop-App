import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemscount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartitem) {
      total = total + (cartitem.price * cartitem.quantity);
    });
    return total;
  }

  void addItem(String productId, double productPrice, String productTitle) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingitem) => CartItem(
              id: existingitem.id,
              title: existingitem.title,
              price: existingitem.price,
              quantity: existingitem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: productTitle,
              price: productPrice,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
