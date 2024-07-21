import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_provider/provider.dart';
import 'storepage.dart';

class NewArrivals extends StatelessWidget {
  const NewArrivals({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
          'New Arrivals',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 2504,
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  if (productProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: productProvider.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                          product: productProvider.products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/store.png',
              width: 24,
              height: 24,
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/liked.png',
              width: 24,
              height: 24,
            ),
            label: 'Liked',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/orders.png',
              width: 24,
              height: 24,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/account.png',
              width: 24,
              height: 24,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

// 
