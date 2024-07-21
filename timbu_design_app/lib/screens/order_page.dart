import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_design_app/screens/storepage.dart';
import '../database/data_base_helper.dart';
import '../models/orders.dart';
import '../product_provider/cart_provider.dart';
// import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../widget/bottom_navigation_bar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Order> _completedOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _loadCompletedOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Future<void> _loadCompletedOrders() async {
  //   // Simulating loading completed orders from an API
  //   final orders = await DatabaseHelper.instance.getCompletedOrders();
  //   setState(() {
  //     _completedOrders = [];
  //   });
  // }

  Future<void> _completeOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final newOrders = cartProvider.items
        .map((item) => Order(
              product: item.product,
              quantity: item.quantity,
              status: OrderStatus.completed,
            ))
        .toList();

    // Here, you would typically save these orders to your database
    // For now, we'll just add them to the _completedOrders list
    setState(() {
      _completedOrders.addAll(newOrders);
    });
    cartProvider.clearCart();
  }

  // Future<void> _completeOrder(BuildContext context) async {
  //   final cartProvider = Provider.of<CartProvider>(context, listen: false);
  //   final newOrders = cartProvider.items
  //       .map((item) => Order(
  //             id: DateTime.now().millisecondsSinceEpoch.toString(),
  //             product: item.product,
  //             quantity: item.quantity,
  //             status: OrderStatus.completed,
  //             orderDate: DateTime.now(),
  //           ))
  //       .toList();

  //   for (var order in newOrders) {
  //     await DatabaseHelper.instance.insertOrder(order);
  //   }

  //   setState(() {
  //     _completedOrders.addAll(newOrders);
  //   });
  //   cartProvider.clearCart();
  //   _loadCompletedOrders();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Orders'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active orders'),
            Tab(text: 'Completed orders'),
          ],
        ),
      ),
      
      body: TabBarView(
        
        controller: _tabController,
        children: [
          _buildActiveOrders(),
          _buildCompletedOrders(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildActiveOrders() {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        if (cartProvider.items.isEmpty) {
          return _buildEmptyState('active');
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    return _buildOrderItem(cartProvider.items[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  // onPressed: () => _completeOrder(context),
                  onPressed: () async {
                    await _completeOrder(context);
                    setState(() {}); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text(
                    'Complete All Orders',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildCompletedOrders() {
    if (_completedOrders.isEmpty) {
      return _buildEmptyState('completed');
    } else {
      return ListView.builder(
        itemCount: _completedOrders.length,
        itemBuilder: (context, index) {
          return _buildOrderItem(_completedOrders[index]);
        },
      );
    }
  }

  Widget _buildEmptyState(String orderType) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.receipt_long, color: Colors.grey[400], size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            'You do not have any $orderType orders',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          if (orderType == 'active')
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StorePage(),
                  ),
                );

                // Navigate to product discovery page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Discover products',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(dynamic item) {
    final bool isCartItem = item is CartItem;
    final Product product = isCartItem ? item.product : item.product;
    final int quantity = isCartItem ? item.quantity : item.quantity;
    final OrderStatus status = isCartItem ? OrderStatus.active : item.status;

    return Container(
      width: double.infinity,
      height: 180,
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(product.photos[0]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            '₦',
                            style: TextStyle(
                              color: Color(0xFF067928),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            product.currentPrice.toString(),
                            style: const TextStyle(
                              color: Color(0xFF067928),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity: $quantity',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (isCartItem)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: quantity > 1
                                      ? () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .decreaseQuantity(product);
                                        }
                                      : null,
                                ),
                                Text('$quantity'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle),
                                  onPressed: () {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .increaseQuantity(product);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (isCartItem)
                        GestureDetector(
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .removeItem(product);
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.delete, color: Colors.red),
                              const SizedBox(width: 4),
                              Text(
                                'Remove',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!isCartItem)
                        Text(
                          'Status: ${status == OrderStatus.completed ? 'Completed' : 'Active'}',
                          style: TextStyle(
                            color: status == OrderStatus.completed
                                ? Colors.green
                                : Colors.orange,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
