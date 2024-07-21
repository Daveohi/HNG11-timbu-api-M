import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product_provider/cart_provider.dart';
import 'payment_successful_page.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({
    super.key,
  });

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // key: _formKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sub Total',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  cart.itemsSubTotal.toStringAsFixed(2),
                  style: const TextStyle(
                      color: Color(0xFF067928),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF067928),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
              ),
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PaymentSuccessfulPage(),
                ));
                // Add your onPressed logic here
                // }
              },
              child: const Text('Make Payment',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
