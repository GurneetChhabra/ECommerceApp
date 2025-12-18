
import 'package:ecommerce_app/models/product.dart';

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
      id: json['productId'],
      title: json['title'] ?? "",
      category: json['category'] ?? "",
      price: json['price'] != null ? json['price'].toDouble : 0,
      image: json['image'] ?? "",
      quantity: json['quantity'] ?? 0,
    );
  }
}

class CartModel{
  final int id;
  final int userId;
  final String date;
  final List<CartItemModel> cartItem;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.cartItem
  });

   factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      cartItem: (json['products'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }
}

