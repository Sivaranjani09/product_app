import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _imageUrlController.text = widget.product.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.label, color: theme.colorScheme.secondary),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Product Description',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.description, color: theme.colorScheme.secondary),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _priceController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Product Price',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.attach_money, color: theme.colorScheme.secondary),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _imageUrlController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Product Image URL',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.image, color: theme.colorScheme.secondary),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        icon: Icon(Icons.save),
                        label: Text('Save Changes'),
                        onPressed: () {
                          final updatedProduct = Product(
                            id: widget.product.id,
                            name: _nameController.text,
                            description: _descriptionController.text,
                            price: double.parse(_priceController.text),
                            imageUrl: _imageUrlController.text,
                          );
                          productProvider.updateProduct(updatedProduct);
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.delete, color: theme.colorScheme.secondary),
                        label: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          productProvider.deleteProduct(widget.product.id);
                          Navigator.pop(context);
                        },
                      ),
                    ],
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





// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/product.dart';
// import '../providers/product_provider.dart';

// class EditProductScreen extends StatefulWidget {
//   final Product product;

//   EditProductScreen({required this.product});

//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _imageUrlController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = widget.product.name;
//     _descriptionController.text = widget.product.description;
//     _priceController.text = widget.product.price.toString();
//     _imageUrlController.text = widget.product.imageUrl;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Product'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: theme.cardTheme.color,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextField(
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                       labelText: 'Product Name',
                      
//                       prefixIcon: Icon(Icons.label, color: theme.colorScheme.secondary),
//                     ),
//                   ),
//                   SizedBox(height: 18),
//                   TextField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(
//                       labelText: 'Product Description',
//                       prefixIcon: Icon(Icons.description, color: theme.colorScheme.secondary),
//                     ),
//                   ),
//                   SizedBox(height: 18),
//                   TextField(
//                     controller: _priceController,
//                     decoration: InputDecoration(
//                       labelText: 'Product Price',
//                       prefixIcon: Icon(Icons.attach_money, color: theme.colorScheme.secondary),
//                     ),
//                     keyboardType: TextInputType.number,
//                   ),
//                   SizedBox(height: 18),
//                   TextField(
//                     controller: _imageUrlController,
//                     decoration: InputDecoration(
//                       labelText: 'Product Image URL',
//                       prefixIcon: Icon(Icons.image, color: theme.colorScheme.secondary),
//                     ),
//                     keyboardType: TextInputType.url,
//                   ),
//                   SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       ElevatedButton.icon(
//                         icon: Icon(Icons.save),
//                         label: Text('Save Changes'),
//                         onPressed: () {
//                           final updatedProduct = Product(
//                             id: widget.product.id,
//                             name: _nameController.text,
//                             description: _descriptionController.text,
//                             price: double.parse(_priceController.text),
//                             imageUrl: _imageUrlController.text,
//                           );
//                           productProvider.updateProduct(updatedProduct);
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ElevatedButton.icon(
//                         icon: Icon(Icons.delete, color: theme.colorScheme.secondary),
//                         label: Text('Delete'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: theme.colorScheme.secondary,
//                           foregroundColor: Colors.white,
//                         ),
//                         onPressed: () {
//                           productProvider.deleteProduct(widget.product.id);
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
