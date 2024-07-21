import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product_provider/cart_provider.dart';
import 'checkout_page.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sub Total',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text('₦',
                      style: TextStyle(color: Color(0xFF067928), fontSize: 16)),
                  const SizedBox(width: 2),
                  Text(
                    cart.itemsSubTotal.toStringAsFixed(2),
                    style: const TextStyle(
                        color: Color(0xFF067928),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF067928),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckoutPage(),
                ),
              );
            },
            child: const Text(
              'Proceed to Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
