import 'package:flutter/material.dart';

import '../models/product.dart';
import '../service/timbu_api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  List<String> _categories = [];
  List<String> get categories => _categories;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final productList = await _apiService.fetchProduct();
      _products = productList.map((item) => Product.fromJson(item)).toList();
    } catch (error) {
      print('Error fetching products: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      _categories = await _apiService.fetchCategories();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load categories: $error');
    }
  }

  Future<void> searchByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      final productList = await _apiService.fetchProduct();
      _products = productList
          .map((item) => Product.fromJson(item))
          .where((product) => product.categories.any(
              (category) => category.toLowerCase() == category.toLowerCase()))
          .toList();
      _isLoading = false;
      notifyListeners();
      // _products = productList
      //     .map((item) => Product.fromJson(item))
      //     .where((product) =>
      //         product.categories.any((category) == category.toLowerCase()))
      //     .toList();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to search products: $error');
    }
  }

  // List<Product> get whitelistedProducts {
  //   return _products.where((product) => product.isWhitelisted).toList();
  // }

  // void toggleWishlistStatus(String productId) {
  //   final index = _products.indexWhere((product) => product.uid == productId);
  //   if (index >= 0) {
  //     _products[index].isWhitelisted = !_products[index].isWhitelisted;
  //     notifyListeners();
  //   }
  // }
}
