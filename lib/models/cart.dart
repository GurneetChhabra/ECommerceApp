
class CartItemModel {
  final int id;
  final String title;
  final String category;
  final double price;
  final String image;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      price: json['price'].toDouble(),
      image: json['image'],
      quantity: json['quantity'] ?? 1,
    );
  }
}

