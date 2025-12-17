import 'dart:convert';

import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/modules/product_card.dart';
import 'package:ecommerce_app/modules/product_details.dart';
import 'package:ecommerce_app/modules/product_list.dart';
import 'package:ecommerce_app/services/cart_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  bool isLoading = true;
  bool isSearching = false;

  late Future<List<String>> categories;
  IconData getIcon(String category) {
    switch (category) {
      case 'electronics':
        return Icons.devices;
      case 'jewelery':
        return Icons.diamond;
      case "men's clothing":
        return Icons.man;
      case "women's clothing":
        return Icons.woman;
      default:
        return Icons.category;
    }
  }

  fetchAllProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      allProducts = data.map((e) => ProductModel.fromJson(e)).toList();
      filteredProducts = allProducts;

      setState(() {
        isLoading = false;
      });
    }
  }

//   void searchProduct(String query) {
//   final result = allProducts.where((product) {
//     final title = product.title.toLowerCase();
//     final search = query.toLowerCase();
//     return title.contains(search);
//   }).toList();

//   setState(() {
//     filteredProducts = result;
//   });
// }

  void searchProduct(String query) {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        filteredProducts = allProducts;
      });
      return;
    }

    final result = allProducts.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      isSearching = true;
      filteredProducts = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    categories = FakeCartApi.fetchCategories();
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: const Color(0xffff3e00),
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home_outlined,
      //           size: 30,
      //         ),
      //         label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      //   ],
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 224, 222, 222),
                          radius: 20,
                          child: Icon(
                            Icons.grid_view_outlined,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 224, 222, 222),
                          radius: 20,
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 222, 222),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      searchProduct(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Icon(Icons.tune, color: Colors.grey),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 140,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xffff7a18), Color(0xffff3e00)],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Super Sale\nDiscount',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        'Up to 50%',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.shopping_bag,
                                    color: Colors.white, size: 60),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                              height: 90,
                              child: FutureBuilder<List<String>>(
                                  future: categories,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox(
                                        height: 70,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      return const Text(
                                          'Failed to load categories');
                                    }

                                    final data = snapshot.data ?? [];
                                    {
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 0.8,
                                        ),
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          // final isSelected = index == 0;

                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductList(
                                                                category:
                                                                    data[index],
                                                              )));
                                                },
                                                child: Container(
                                                    height: 48,
                                                    width: 48,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 224, 222, 222),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                        getIcon(data[index]))),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                data[index],
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  })),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Special For You",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(240, 0, 0, 0)),
                        ),
                        Text(
                          "See all",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(100, 0, 0, 0)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 222, 222),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.favorite_border,
                                  color: Colors.orange[400]),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Icon(Icons.headphones,
                                  size: 60, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            const Text('Wireless Headphones',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            const Text('\$70.00',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            if (isSearching)
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.white,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(image: product.image, title: product.title, price: product.price)));
                              },
                              child: ProductCard(item: product));
                          },
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
