import 'package:ecommerce_app/controllers/cart_controller.dart';
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

  @override
  void initState() {
    super.initState();
    cartFuture = FakeCartApi.fetchCartItems().then((items) {
      var addedProducts = [...items];
      for (final localItem in CartController.localCart) {
      final index =
          addedProducts.indexWhere((item) => item.id == localItem.id);

      if (index != -1) {
        addedProducts[index].quantity += localItem.quantity;
      } else {
        addedProducts.add(localItem);
      }
    }
      cartItems = addedProducts;

      return cartItems;
    });
  }

  void incrementQty(int index) {
    setState(() {
      cartItems[index].quantity += 1;
    });
  }

  void decrementQty(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double get subtotal {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
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

          if (cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(id: cartItems[index].id),
                          ),
                        );
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
                ),
              ),

              _billSection(),
            ],
          );
        },
      ),
    );
  }

  Widget _billSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _billRow("Subtotal", subtotal),
          const SizedBox(height: 8),
          _billRow("Delivery", 0),
          const Divider(height: 24),
          _billRow(
            "Total",
            subtotal,
            isBold: true,
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Checkout",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _billRow(String title, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
