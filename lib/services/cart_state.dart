import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartState extends ChangeNotifier{

  List<CartItemModel> cartItems = [];

  setCartItems(List<CartItemModel> items){
    cartItems = items;
    notifyListeners();
  }

  addToCart(ProductModel product, {int quantity = 1}){
      cartItems.add( CartItemModel(
          id: product.id,
          title: product.title,
          category: product.category,
          price: product.price,
          image: product.image,
          quantity: quantity,
        ));
        notifyListeners();
  }
}