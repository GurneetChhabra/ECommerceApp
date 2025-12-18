import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xffF2F2F2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Image.network(
                item.image,
                height: 55,
                width: 55,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        onDelete();
                      },
                      child: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Color(0xffff7a00),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  item.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${item.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              onRemove();
                            },
                            child: Container(
                              width: 30,
                              height: 20,
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              onAdd();
                            },
                            child: Container(
                              width: 30,
                              height: 20,
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
