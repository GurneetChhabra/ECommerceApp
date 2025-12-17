import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/cart_api.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  // final String title;
  // final String image;
  // final double price;

  const ProductDetailScreen({
    super.key,
    required this.id,
    // required this.title,
    // required this.image,
    // required this.price,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductModel? product;
  int selectedColorIndex = 0;

  final List<Color> availableColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.grey,
  ];

  getProduct() async{
  product = await FakeCartApi.fetchProductsById(widget.id);
  if(product != null){
    setState(() {
      
    });
  }
  }

  @override
  void initState() {
    // TODO: implement initState
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return product != null ? Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            /// 🔹 Product Image Section
            Container(
              height: 320,
              width: double.infinity,
              color: const Color(0xfff2f2f2),
              child: Center(
                child: Image.network(
                  product!.image,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
        
            /// 🔹 Top Bar
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    Row(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.share, color: Colors.black),
                        ),
                        SizedBox(width: 8),
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
        
            /// 🔹 Bottom Details Section
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
        
                /// ✅ SCROLL FIX (THIS IS THE KEY)
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(
                        product!.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
        
                      const SizedBox(height: 6),
        
                      /// Price
                      Text(
                        "\$${product!.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
        
                      const SizedBox(height: 8),
        
                      /// Rating Row
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          SizedBox(width: 4),
                          Text("4.8"),
                          SizedBox(width: 6),
                          Text(
                            "(320 Reviews)",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          Text(
                            "Seller: Syed Noman",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
        
                      const SizedBox(height: 16),
        
                      /// Color Title
                      const Text(
                        "Color",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
        
                      const SizedBox(height: 8),
        
                      /// ✅ WORKING COLOR SELECTION
                      Row(
                        children: List.generate(availableColors.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColorIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedColorIndex == index
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: availableColors[index],
                              ),
                            ),
                          );
                        }),
                      ),
        
                      const SizedBox(height: 20),
        
                      /// Tabs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _tabButton("Description"),
                          _tabButton("Specifications"),
                          _tabButton("Reviews"),
                        ],
                      ),
        
                      const SizedBox(height: 12),
        
                      /// Description
                      const Text(
                        "Lorem Ipsum is simply dummy text of the printing and "
                        "typesetting industry. Lorem Ipsum has been the "
                        "industry's standard dummy text ever since the 1500s.",
                        style: TextStyle(color: Colors.grey),
                      ),
        
                      const SizedBox(height: 80), // space above bottom bar
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /// 🔹 Bottom Cart Bar (FIXED)
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
    ) : const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _tabButton(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
