import 'package:flutter/material.dart';

import '../database/data_base_helper.dart';
import '../models/orders.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
   List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.name == product.name);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.name == product.name);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.name == product.name);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  int get itemCount => _items.length;

  double get delivery => 5000;

  double get services => 3500;

  double get itemsSubTotal => _items.fold(
      0, (total, item) => total + item.product.currentPrice * item.quantity);

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.product.currentPrice * item.quantity));
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }

// Future<void> completeOrder() async {
//     final newOrders = items
//         .map((item) => Order(
//               id: DateTime.now().millisecondsSinceEpoch.toString(),
//               product: item.product,
//               quantity: item.quantity,
//               status: OrderStatus.completed,
//               orderDate: DateTime.now(),
//             ))
//         .toList();

//     for (var order in newOrders) {
//       await DatabaseHelper.instance.insertOrder(order);
//     }

//     clearCart();
//     notifyListeners();
//   }

  void completeOrder() {
    // Here you would typically save the order to a database
    // For now, we'll just clear the cart
    clearCart();
    notifyListeners();
  }
  
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
