import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/modules/product_card.dart';
import 'package:ecommerce_app/modules/product_details.dart';
import 'package:ecommerce_app/services/cart_api.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/modules/cart_item_card.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final String? category;
   const ProductList({super.key,this.category});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<ProductModel>> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = FakeCartApi.fetchProductsByCategory(widget.category!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        title: const Text("Product List", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(id: data[index].id)));
                },
                child: ProductCard(item: data[index]));
            },
          );
        },
      ),
    );
  }
}
