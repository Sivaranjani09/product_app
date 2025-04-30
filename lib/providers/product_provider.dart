import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products]; 
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
  Future<void> fetchProducts() async {
    final url = Uri.parse('http://localhost:5000/api/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data is List) {
          _products = data.map((item) => Product.fromJson(item)).toList();
        } else if (data is Map<String, dynamic>) {
          _products = [Product.fromJson(data)];
        }
        notifyListeners();
      } else {
        debugPrint('Fetch products failed: \n${response.body}');
        throw Exception('Failed to load products: ${response.body}');
      }
    } catch (error) {
      debugPrint('Fetch products error: $error');
      rethrow;
    }
  }
  Future<void> addProduct(Product product) async {
    final url = Uri.parse('http://localhost:5000/api/products');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);

        Product parsedProduct;
        if (data is List && data.isNotEmpty) {
          parsedProduct = Product.fromJson(data.first);
        } else if (data is Map<String, dynamic>) {
          parsedProduct = Product.fromJson(data);
        } else {
          throw Exception('Unexpected response format');
        }

        _products.add(parsedProduct);
        notifyListeners();
      } else {
        debugPrint('Add product failed: \n${response.body}');
        throw Exception('Failed to add product: ${response.body}');
      }
    } catch (error) {
      debugPrint('Add product error: $error');
      rethrow;
    }
  }
  Future<void> updateProduct(Product product) async {
    final url = Uri.parse('http://localhost:5000/api/products/${product.id}');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final prodIndex = _products.indexWhere((p) => p.id == product.id);
        if (prodIndex >= 0) {
          _products[prodIndex] = product;
          notifyListeners();
        }
      } else {
        debugPrint('Update product failed: \n${response.body}');
        throw Exception('Failed to update product: ${response.body}');
      }
    } catch (error) {
      debugPrint('Update product error: $error');
      rethrow;
    }
  }
  Future<void> deleteProduct(String productId) async {
    final url = Uri.parse('http://localhost:5000/api/products/$productId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _products.removeWhere((prod) => prod.id == productId);
        notifyListeners();
      } else {
        debugPrint('Delete product failed: \n${response.body}');
        throw Exception('Failed to delete product: ${response.body}');
      }
    } catch (error) {
      debugPrint('Delete product error: $error');
      rethrow;
    }
  }
}


