import 'package:flutter/material.dart';

class CouponCodeSection extends StatelessWidget {
  const CouponCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.24),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Do you have a Coupon Code?',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Coupon Code',
                    hintStyle: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  side: const BorderSide(
                      color: Color(0xFF067928), style: BorderStyle.solid),
                ),
                onPressed: () {},
                child: const Text(
                  'Apply',
                  style: TextStyle(color: Color(0xFF067928)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
