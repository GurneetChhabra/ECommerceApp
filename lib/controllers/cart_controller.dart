import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';

class CartController {
  static final List<CartItemModel> localCart = [];

  static void addToCart(ProductModel product, {int quantity = 1}) {
    final index =
        localCart.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      localCart[index].quantity += quantity;
    } else {
      localCart.add(
        CartItemModel(
          id: product.id,
          title: product.title,
          category: product.category,
          price: product.price,
          image: product.image,
          quantity: quantity,
        ),
      );
    }
  }

  static void clearLocalCart() {
    localCart.clear();
  }
}
