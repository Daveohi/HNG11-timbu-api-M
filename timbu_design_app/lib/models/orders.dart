import 'product.dart';

enum OrderStatus { active, completed }

class Order {
  final Product product;
  final int quantity;
  final OrderStatus status;

  Order({
    required this.product,
    required this.quantity,
    required this.status,
  });
}
