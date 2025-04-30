import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = []; // Private list of products

  List<Product> get products {
    return [..._products]; // Return a copy of the product list
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
  // Fetch products from the backend
  Future<void> fetchProducts() async {
    final url = Uri.parse('http://localhost:5000/api/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        // Defensive: handle if backend returns a list or single object
        if (data is List) {
          _products = data
              .map((data) => Product.fromJson(data)) // Map each product data to Product model
              .toList();
        } else if (data is Map<String, dynamic>) {
          _products = [Product.fromJson(data)];
        }
        notifyListeners(); // Notify listeners to update UI
      } else {
        debugPrint('Fetch products failed: \n${response.body}');
        throw Exception('Failed to load products: ${response.body}');
      }
    } catch (error) {
      debugPrint('Fetch products error: $error');
      rethrow;
    }
  }

  // Add a new product to the backend and the local list
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

          print('--- Add Product Response ---');
          print(response.body); // See the raw JSON
          Product parsedProduct = Product.fromJson(data is List ? data.first : data);
          print('Parsed Image URL: ${parsedProduct.imageUrl}');
        print('--------------------------');
        _products.add(parsedProduct); 


        // Defensive: handle if backend returns a list or single object
        if (data is List && data.isNotEmpty) {
          _products.add(Product.fromJson(data.first));
        } else if (data is Map<String, dynamic>) {
          _products.add(Product.fromJson(data));
        }
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

  // Update an existing product in the backend and the local list
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

  // Delete a product from the backend and the local list
  Future<void> deleteProduct(String productId) async {
    final url = Uri.parse('http://localhost:5000/api/products/$productId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _products.removeWhere((prod) => prod.id == productId); // Remove from list
        notifyListeners(); // Notify listeners to update UI
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
