import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_design_app/models/product.dart';
import 'package:timbu_design_app/screens/new_arrivals.dart';
// import 'package:timbu_design_app/screens/order_page.dart';
import 'package:timbu_design_app/widget/bottom_navigation_bar.dart';
import '../product_provider/cart_provider.dart';
import '../product_provider/provider.dart';
import 'cart_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
      Provider.of<ProductProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: 'Search for anything',
            // suffixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_selectedCategory != null) {
                  productProvider.searchByCategory(_selectedCategory!);
                }
              },
            ),
            suffixIconColor: Colors.black45,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          // onSubmitted: (_) => _performSearch(),
          value: _selectedCategory,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
            });
          },
          items: productProvider.categories
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black54),
              onPressed: () {}),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/cart-icon.png',
                  width: 44,
                  height: 44,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
              ),
              if (cart.itemCount >= 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (cart.items.isEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                  ),
                ),
            ],
          ),
        ],
        toolbarHeight: 120,
      ),
      backgroundColor: Colors.white,
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                      'assets/hero-image.png'), // Replace with your banner image
                  const ProductSection(
                    title: 'New Arrivals',
                    products: [],
                  ),
                  const ProductSection(
                    title: 'Top Sellers',
                    products: [],
                  ),
                  const ProductSection(
                    title: 'More of what you like',
                    products: [],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

class ProductSection extends StatelessWidget {
  final String title;
  final List<Product> products;

  const ProductSection(
      {super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    // final productModel = Provider.of<Product>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewArrivals(title: ''),
                      ),
                    );
                  },
                  child: const Text(
                    'See more',
                    style: TextStyle(color: Color(0xFF067928)),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              if (productProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (productProvider.products.isEmpty) {
                return const Center(child: Text('No products available'));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productProvider.products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductCard(product: productProvider.products[index]);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 280,
          child: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              if (productProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (productProvider.products.isEmpty) {
                return const Center(child: Text('No products available'));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productProvider.products.length,
                addRepaintBoundaries: true,
                itemBuilder: (context, index) {
                  return ProductCard(product: productProvider.products[index]);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 1100,
          child: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              if (productProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (productProvider.products.isEmpty) {
                return const Center(child: Text('No products available'));
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 10,
                ),
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: productProvider.products[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        cart.addItem(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.name} added to cart'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      onLongPress: () {
        productProvider.toggleWishlist(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              productProvider.isWhitelisted(product)
                  ? '${product.name} added to wishlist'
                  : '${product.name} removed from wishlist',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(product.photos[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('N${product.currentPrice}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF067928))),
            Text(
              style: const TextStyle(color: Colors.black),
              product.name,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  product.status,
                  style: const TextStyle(color: Colors.black45),
                ),
                const Icon(Icons.star, size: 16, color: Colors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
