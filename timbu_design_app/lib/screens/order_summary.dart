import 'package:flutter/material.dart';

class OrderSummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const OrderSummaryItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
