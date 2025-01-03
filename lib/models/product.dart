class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'], // Ensure this is a valid image URL or asset path
      description: json['description'],
      rating: json['rating'],
    );
  }
}
