import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import 'edit_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const lightText = Color(0xFFE0E1DD);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: TextStyle(color: lightText)),
        iconTheme: IconThemeData(color: lightText),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: theme.cardColor,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.imageUrl.isNotEmpty)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          product.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, error, stackTrace) => Icon(Icons.broken_image, size: 100, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 24),
                Text(
                  product.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: const Color.fromARGB(255, 10, 12, 3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Price: ₹${product.price.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge?.copyWith(color: const Color.fromARGB(255, 10, 12, 3)),
                ),
                SizedBox(height: 12),
                Text(
                  product.description,
                  style: theme.textTheme.bodyLarge?.copyWith(color: const Color.fromARGB(255, 10, 12, 3)),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: Icon(Icons.edit, color: lightText),
                      label: Text('Edit Product', style: TextStyle(color: lightText)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => EditProductScreen(product: product),
                          ),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.delete, color: lightText),
                      label: Text('Delete', style: TextStyle(color: lightText)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                      ),
                      onPressed: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: theme.cardColor,
                            title: Text('Confirm Deletion', style: TextStyle(color: Colors.black)),
                            content: Text('Are you sure you want to delete this product?', style: TextStyle(color: Colors.black)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: Text('Delete', style: TextStyle(color: theme.colorScheme.error)),
                              ),
                            ],
                          ),
                        );

                        if (shouldDelete == true) {
                          try {
                            await Provider.of<ProductProvider>(context, listen: false)
                                .deleteProduct(product.id);
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete product')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







