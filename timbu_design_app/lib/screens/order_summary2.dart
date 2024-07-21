import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_design_app/screens/order_summary.dart';

import '../product_provider/cart_provider.dart';

class OrderSummary2 extends StatelessWidget {
  const OrderSummary2({super.key, required List cartItems});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Text(
            'Order Summary',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 16),
          OrderSummaryItem(
            title: 'Items',
            value: cart.itemCount.toString(),
          ),
          OrderSummaryItem(
              title: 'Delivery', value: '₦${cart.delivery.toString()}'),
          OrderSummaryItem(
              title: 'Services', value: '₦${cart.services.toString()}'),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
