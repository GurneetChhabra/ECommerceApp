import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String image;
  final String title;
  final double price;

  const ProductDetailScreen({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: [
          Container(
            height: 320,
            width: double.infinity,
            color: const Color(0xfff2f2f2),
            child: Center(
              child: Image.network(
                width: 200,
                height: 200,
                widget.image,
                // fit: BoxFit.contain,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(Icons.share, color: Colors.black),
    ),
                    
                      const SizedBox(width: 8),
                      CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(Icons.favorite_border, color: Colors.black),
    ),
                    ],
                  )
                ],
              ),
            ),
          ),

          Positioned(
            top: 280,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "\$${widget.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      SizedBox(width: 4),
                      Text("4.8"),
                      SizedBox(width: 6),
                      Text("(320 Reviews)",
                          style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      Text(
                        "Seller: Syed Noman",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Color",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      _colorDot(Colors.black),
                      _colorDot(Colors.red),
                      _colorDot(Colors.orange),
                      _colorDot(Colors.blue),
                      _colorDot(Colors.grey),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _tabButton("Description", 0),
                      _tabButton("Specifications", 1),
                      _tabButton("Reviews", 2),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SingleChildScrollView(
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and "
                      "typesetting industry. Lorem Ipsum has been the "
                      "industry's standard dummy text ever since the 1500s.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.remove, size: 18),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("1"),
                    ),
                    Icon(Icons.add, size: 18),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _tabButton(String text, int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color:
              selectedTab == index ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedTab == index
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
