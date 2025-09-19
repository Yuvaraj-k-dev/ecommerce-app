import 'dart:convert';

import 'package:ecommerce/models/products.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  final String _baseUrl = 'https://fakestoreapi.com/products/';

  Future<List<Products>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((product) => Products.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
