import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final theme = Theme.of(context);
    final Color lightText = Color(0xFFE0E1DD);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product', style: TextStyle(color: lightText)),
        iconTheme: IconThemeData(color: lightText),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
             padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: lightText),
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: lightText),
                      prefixIcon: Icon(Icons.label, color: lightText),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _descriptionController,
                    style: TextStyle(color: lightText),
                    decoration: InputDecoration(
                      labelText: 'Product Description',
                      labelStyle: TextStyle(color: lightText),
                      prefixIcon: Icon(Icons.description, color: lightText),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _priceController,
                    style: TextStyle(color: lightText),
                    decoration: InputDecoration(
                      labelText: 'Product Price',
                      labelStyle: TextStyle(color: lightText),
                      prefixIcon: Icon(Icons.currency_rupee, color: lightText),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _imageUrlController,
                    style: TextStyle(color: lightText),
                    decoration: InputDecoration(
                      labelText: 'Product Image URL',
                      labelStyle: TextStyle(color: lightText),
                      prefixIcon: Icon(Icons.image, color: lightText),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add, color: lightText),
                    label: Text('Add Product', style: TextStyle(color: lightText)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: lightText,
                    ),
                    onPressed: () async {
                      final name = _nameController.text.trim();
                      final description = _descriptionController.text.trim();
                      final price = double.tryParse(_priceController.text) ?? 0;
                      final imageUrl = _imageUrlController.text.trim();
                      if (name.isEmpty || description.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Name and Description are required', style: TextStyle(color: lightText))),
                        );
                        return;
                      }
                      try {
                        await productProvider.addProduct(Product(
                          id: '', // Let backend assign id
                          name: name,
                          description: description,
                          price: price,
                          imageUrl: imageUrl,
                        ));
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add product', style: TextStyle(color: lightText))),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
