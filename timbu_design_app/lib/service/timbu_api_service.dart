import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/product.dart';
// import 'package:sherrie_signature/models/products.dart';

class ApiService {
  final String baseUrl = 'https://api.timbu.cloud/products';
  final String apiKey = '7a66eded2090437e80eab559b5243aeb20240709162209937023';
  final String appId = 'QJYEE8E2USWEGUY';
  final organizationId = '5f7d30c0216549d484bf2e87f357ec4f';
  final String categoryUrl = 'https://api.timbu.cloud/categories';

  Future<List<dynamic>> fetchProduct() async {
    final queryParams = {
      'organization_id': organizationId,
      "reverse_sort": "false",
      "page": "1",
      "size": "20",
      'ApiKey': apiKey,
      'Appid': appId,
    };
    final uri = Uri.parse(
        '$baseUrl?organization_id=$organizationId&reverse_sort=false&page=1&size=20&Appid=$appId&Apikey=$apiKey');
    print('Fetching product from: $uri');
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        var item = json.decode(response.body);
        return item['items'];
      } else {
        List<dynamic> items = json.decode(response.body)['items'];
        print('Fetched products: $items');
        return items.map((item) => Product.fromJson(item)).toList();
      }
    } catch (error) {
      if (kIsWeb) {
        throw Exception('CORS policy error: ${error.toString()}');
      } else {
        throw Exception('Failed to load data: ${error.toString()}');
      }
    }
  }

  Future<Map<String, dynamic>> fetchOneProduct(String id) async {
    final queryParams = {
      'organization_id': organizationId,
      "reverse_sort": "false",
      "page": "1",
      "size": "20",
      'ApiKey': apiKey,
      'Appid': appId,
    };
    final uri = Uri.parse(
        '$baseUrl/$id?organization_id=$organizationId&reverse_sort=false&page=1&size=20&Appid=$appId&Apikey=$apiKey');
    print('Fetching product from: $uri');
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        var item = json.decode(response.body);
        return item;
      } else {
        print('Request failed');
        //List<dynamic> items = json.decode(response.body)['items'];
        // print('Fetched products: $items');
        return {};
      }
    } catch (error) {
      print(error);
      return {};
    }
  }

  Future<List<String>> fetchCategories() async {
    final uri = Uri.parse(
        '$categoryUrl?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey');
    print('Fetching categories from: $uri');
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<String> categories = (data['items'] as List)
            .map((item) => item['name'] as String)
            .toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      throw Exception('Failed to load categories: ${error.toString()}');
    }
  }
}
