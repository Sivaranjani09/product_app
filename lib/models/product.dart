class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // From JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? json['id'], // Accept both _id and id
      name: json['name'],
      description: json['description'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'].toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
