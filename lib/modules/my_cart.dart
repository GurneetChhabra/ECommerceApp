import 'package:ecommerce_app/modules/product_details.dart';
import 'package:ecommerce_app/services/cart_api.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/modules/cart_item_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartItemModel>> cartFuture;
  List<CartItemModel> cartItems = [];
   void incrementQty(int index) {
    print("increasing the qty");
    setState(() {
      cartItems[index].quantity += 1;
    });
  }

  void decrementQty(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    cartFuture = FakeCartApi.fetchCartItems().then((items) {
    cartItems = items;
    return items;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<CartItemModel>>(
        future: cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }


          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(id: cartItems[index].id)));
                },
                child: CartItemCard(
                  key: ValueKey(cartItems[index].id),
                  item: cartItems[index],
                    onAdd: () => incrementQty(index),
                    onRemove: () => decrementQty(index),
                    onDelete: () => removeItem(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
