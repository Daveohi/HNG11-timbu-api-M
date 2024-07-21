// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/product.dart';
// import '../product_provider/provider.dart';

// class LikedPage extends StatelessWidget {
//   const LikedPage({super.key, required this.product});

//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         actions: [
//           Consumer<ProductProvider>(
//             builder: (context, productProvider, child) {
//               return IconButton(
//                 icon: Icon(
//                   product.isWhitelisted ? Icons.favorite : Icons.favorite_border,
//                   color: product.isWhitelisted ? Colors.red : Colors.white,
//                 ),
//                 onPressed: () {
//                   productProvider.toggleWishlistStatus(product.uid);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         product.isWhitelisted
//                             ? 'Removed from wishlist'
//                             : 'Added to wishlist',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }