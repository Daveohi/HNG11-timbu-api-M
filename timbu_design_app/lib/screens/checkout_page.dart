import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_design_app/models/product.dart';
import '../product_provider/cart_provider.dart';
import 'coupon_code_section.dart';
import 'customer_info_form.dart';
import 'make_payment.dart';
import 'order_summary.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isDelivery = true;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: Colors.black,
          iconSize: 40,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Items',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...cart.items.map((cartItem) => CartItemWidget(
                        item: cartItem.product,
                        quantity: cartItem.quantity,
                      )),
                  const SizedBox(height: 16),
                  const Text('Delivery Options',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ToggleButtons(
                    isSelected: [isDelivery, !isDelivery],
                    onPressed: (index) {
                      setState(() {
                        isDelivery = index == 0;
                      });
                    },
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        child: Text(
                          'Delivery',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Text(
                          'Pickup',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const CustomerInfoForm(),
                  const SizedBox(height: 32),
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  OrderSummaryItem(title: 'Items', value: '${cart.itemCount}'),
                  OrderSummaryItem(
                      title: 'Delivery', value: '₦${cart.delivery}'),
                  OrderSummaryItem(
                      title: 'Services', value: '₦${cart.services}'),
                  const SizedBox(height: 32),
                  const CouponCodeSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          const MakePayment(),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Product item;
  final int quantity;

  const CartItemWidget({super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(item.photos[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                Text(
                  '₦${item.currentPrice}',
                  style: const TextStyle(color: Color(0xFF067928)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.size),
              Text('x$quantity'),
            ],
          ),
        ],
      ),
    );
  }
}
