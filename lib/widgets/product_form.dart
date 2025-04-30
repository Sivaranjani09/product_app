import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductForm extends StatefulWidget {
  final Product? product; // The product to edit (null if adding a new product)

  ProductForm({this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController(); // NEW

  // Set initial values if the product is passed (for editing)
  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _imageUrlController.text = widget.product!.imageUrl; // NEW
    }
  }

  void _submitForm() {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final imageUrl = _imageUrlController.text; // NEW

    if (name.isEmpty || description.isEmpty || imageUrl.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields with valid values.')),
      );
      return;
    }

    final newProduct = Product(
      id: widget.product?.id ?? '', // Keep the ID if editing, else set empty
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl, // NEW
    );

    if (widget.product == null) {
      Provider.of<ProductProvider>(context, listen: false).addProduct(newProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false).updateProduct(newProduct);
    }

    Navigator.pop(context); // Return after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _imageUrlController, // NEW
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(widget.product == null ? 'Add Product' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
