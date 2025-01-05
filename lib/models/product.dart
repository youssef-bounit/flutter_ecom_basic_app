class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final double rating;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.rating,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
      rating: json['rating'],
      quantity: json['quantity'],
    );
  }
}
