import 'dart:convert';

import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:http/http.dart' as http;

class FakeCartApi {

  static Future<List<CartItemModel>> fetchCartItems() async {
    await Future.delayed(const Duration(seconds: 2)); 

    final String _baseUrl = 'https://fakestoreapi.com/products';



    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> cartItemJson = jsonDecode(response.body);


      return cartItemJson.map((json) => CartItemModel.fromJson(json)).toList();
    } else {
      throw Exception('failed to load Products');
    }
  }

    static Future<List<String>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    final String _baseUrl = 'https://fakestoreapi.com/products/categories';

    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
   List<dynamic> jsonList = json.decode(response.body);
    List<String> categories = jsonList.map((item) => item.toString()).toList();

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


    return productJson
        .map((json) => ProductModel.fromJson(json))
        .toList();
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
    final  data = jsonDecode(response.body);

    ProductModel? product = ProductModel.fromJson(data);
   return product;

  } else{
    throw Exception("Failed to load product");
  }
}


}
