import 'dart:convert';

import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FakeCartApi {
  static const String _productUrl = 'https://fakestoreapi.com/products';
  List<CartItemModel> cartItems = [];


   Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    final response = await http.get(Uri.parse(_productUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      
      List<ProductModel> data1 = data.map((json) => ProductModel.fromJson(json)).toList();
        for (int i=1;i<4;i++) {


          // products.add(product);
          cartItems.add(
            CartItemModel(
              id: i,
              title: data1[i].title,
              category: data1[i].category,
              image: data1[i].image,
              price: data1[i].price,
              quantity: i==1 ? 4 : i==2 ? 1: i==3 ? 6 : 10,
            ),
          );
        
      }
      Provider.of<CartState>(context, listen: false).setCartItems(cartItems);
         return data1;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<CartItemModel>> fetchCartItems() async {
    // await Future.delayed(const Duration(seconds: 2));

    // final String _baseUrl = 'https://fakestoreapi.com/carts/1';

    // final response = await http.get(Uri.parse(_baseUrl));

    // if (response.statusCode == 200) {
    //   final cartJson = jsonDecode(response.body);

    //   CartModel cart = CartModel.fromJson(cartJson);
      List<CartItemModel> cartItems = [];
      for (int i=1;i<4;i++) {
        final product = await FakeCartApi.fetchProductsById(i);

        if (product != null) {
          // products.add(product);
          cartItems.add(
            CartItemModel(
              id: i,
              title: product.title,
              category: product.category,
              image: product.image,
              price: product.price,
              quantity: i==1 ? 4 : i==2 ? 1: i==3 ? 6 : 10,
            ),
          );
        }
      }
      return cartItems;
    // } else {
    //   throw Exception('failed to load Products');
    // }
  }

   List<CartItemModel> getCartItems(){
    return cartItems;
   }

  static Future<List<String>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    final String _baseUrl = 'https://fakestoreapi.com/products/categories';

    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<String> categories =
          jsonList.map((item) => item.toString()).toList();

      return categories;
    } else {
      throw Exception('failed to load categories');
    }
  }

  static Future<List<ProductModel>> fetchProductsByCategory(
    String category,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final String baseUrl =
        'https://fakestoreapi.com/products/category/$category';

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> productJson = jsonDecode(response.body);

      return productJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products for category: $category');
    }
  }

  static Future<ProductModel?> fetchProductsById(int id) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/$id'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      ProductModel? product = ProductModel.fromJson(data);
      return product;
    } else {
      throw Exception("Failed to load product");
    }
  }
}
