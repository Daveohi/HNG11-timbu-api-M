// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:timbu_design_app/screens/storepage.dart';

// import '../product_provider/provider.dart';

// class WhitelistPage extends StatelessWidget {
//   // static const routeName = '/wishlist';

//   const WhitelistPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const String imgUrl = 'http://api.timbu.cloud/images/';

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Wishlist', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Consumer<ProductProvider>(
//         builder: (context, productProvider, child) {
//           final whitelistItems = productProvider.whitelistedProducts;
//           if (whitelistItems.isEmpty) {
//             return const Center(child: Text('Your wishlist is empty.'));
//           }

//           return GridView.builder(
//             padding: const EdgeInsets.all(10),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemCount: whitelistItems.length,
//             itemBuilder: (context, index) {
//               final product = whitelistItems[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(
//                     context,
//                     imgUrl,
//                     arguments: product,
//                   );
//                 },
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 120,
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10),
//                           ),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               '$imgUrl${product.photos.isNotEmpty ? product.photos[0] : 'placeholder.jpg'}',
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text(
//                             //   product.brand,
//                             //   style:
//                             //       const TextStyle(fontSize: 12, color: Colors.grey),
//                             // ),
//                             Text(
//                               product.name,
//                               style: const TextStyle(
//                                   fontSize: 14, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               '₦${product.currentPrice}',
//                               style:
//                                   const TextStyle(fontSize: 14, color: Colors.blue),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
