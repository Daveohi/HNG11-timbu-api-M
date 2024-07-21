import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_design_app/screens/storepage.dart';
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
    _loadCompletedOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadCompletedOrders() {
    // Simulating loading completed orders from an API
    setState(() {
      _completedOrders = [];
    });
  }

  void _completeOrder(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    setState(() {
      _completedOrders.addAll(cartProvider.items.map((item) => Order(
          product: item.product,
          quantity: item.quantity,
          status: OrderStatus.completed)));
    });
    cartProvider.clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () => _completeOrder(context),
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
    final Product product = item is CartItem ? item.product : item.product;
    final int quantity = item is CartItem ? item.quantity : item.quantity;
    final bool isActive = item is CartItem;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(item.product.photos[0]),
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
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text('Quantity: $quantity'),
                  const SizedBox(height: 4),
                  Text(
                    '₦${(product.currentPrice * quantity).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (isActive)
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .decreaseQuantity(product);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .increaseQuantity(product);
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
