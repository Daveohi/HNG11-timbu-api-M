// import 'package:flutter/foundation.dart';

class Product {
  final String uid;
  final String name;
  final String description;
  final String dateCreated;
  final int availableQuantity;
  final double currentPrice;
  final String status;
  final List<String> photos;
  final String size;
  bool isWhitelisted;
  final List<String> categories;
  // final String size;

  Product({
    required this.uid,
    required this.name,
    required this.description,
    required this.dateCreated,
    required this.availableQuantity,
    required this.currentPrice,
    required this.status,
    required this.photos,
    required this.size,
    required this.categories,
    // required this.size,
    this.isWhitelisted = false,
    // required this.categoryId,
    // required this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double price = 0.0;
    if (json['current_price'] is List && json['current_price'].isNotEmpty) {
      var currentPriceData = json['current_price'][0];
      if (currentPriceData is Map<String, dynamic> &&
          currentPriceData['NGN'] is List &&
          currentPriceData['NGN'].isNotEmpty) {
        price = currentPriceData['NGN'][0] ?? 0.0;
      }
    }
    return Product(
      uid: json['unique_id'] ?? '',
      name: json['name'] ?? '',
      description:
          json['description'] == 'null' ? '' : json['description'] ?? '',
      dateCreated: json['date_created'] ?? '',
      availableQuantity: (json['available_quantity'] ?? 0).toInt(),
      currentPrice: price,
      status: json['status'] ?? '4.5',
      photos: (json['photos'] as List<dynamic>)
          .map((photo) =>
              'https://api.timbu.cloud/images/${photo['url'] as String}')
          .toList(),
      categories: (json['categories'] as List<dynamic>).map((category) => category.toString()).toList(),
      size: json['size'] ?? '',
    );
  }
  //  static double _parseCurrentPrice(dynamic currentPrice) {
  //   if (currentPrice is List && currentPrice.isNotEmpty) {
  //     var ngnPrice = currentPrice[0]['NGN'];
  //     if (ngnPrice is List && ngnPrice.isNotEmpty && ngnPrice[0] is int) {
  //       return ngnPrice[0];
  //     }
  //   }
  //   return 0.0;
  // }
}

// class Product {
//   final String name;
//   final String currency;
//   final List<dynamic> photos;
//   final int quantityAvailable;
//   final List<dynamic> currentPrice;
//   final double sellingPrice;
//   final String description;
//   final String category;
  

//   Product(
//       {required this.name,
//       required this.currency,
//       required this.photos,
//       required this.quantityAvailable,
//       required this.currentPrice,
//       required this.sellingPrice,
//       required this.description,
//       required this.category});

  

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       name: json['name'] ?? 'Unknown Product',
//       currency: json['currency'] ?? '',
//       photos: (json['photos'] as List?)?.cast<String>() ?? [],
//       quantityAvailable: json['quantityAvailable'] ?? 0,
//       currentPrice: (json['current_Price'] as List?)?.cast<dynamic>() ?? [],
//       sellingPrice: (json['sellingPrice'] ?? 0).toDouble(),
//       description: json['description'] ?? '',
//       category: json['category'] ?? 'Uncategorized',


      // name: json['name'],
      // currency: json['currency'],
      // photos: json['photos'] ,
      // quantityAvailable: json['quantityAvailable'],
      // currentPrice: json['current_Price'],
      // sellingPrice: json['sellingPrice'],
      // description: json['description'],
      // category: json['category']
    // );
  // }

  
// }
