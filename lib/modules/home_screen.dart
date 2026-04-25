import 'dart:convert';

import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/modules/product_card.dart';
import 'package:ecommerce_app/modules/product_details.dart';
import 'package:ecommerce_app/modules/product_list.dart';
import 'package:ecommerce_app/services/cart_api.dart';
import 'package:ecommerce_app/services/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  fetchAllProducts(BuildContext context) async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      allProducts = data.map((e) => ProductModel.fromJson(e)).toList();
      filteredProducts = allProducts;

      List<CartItemModel> cartItems = [];
      for (int i=0;i<3;i++) {


          // products.add(product);
          cartItems.add(
            CartItemModel(
              id: i,
              title: allProducts[i].title,
              category: allProducts[i].category,
              image:  allProducts[i].image,
              price: allProducts[i].price,
              quantity: i==0 ? 4 : i==1 ? 1: i==2 ? 6 : 10,
            ),
          );
        
      }
    Provider.of<CartState>(context, listen: false).setCartItems(cartItems);
      setState(() {
        isLoading = false;
      });
    }
  }



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
    fetchAllProducts(context);
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
                            Icons.grid_view_rounded,
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
                                Icon(Icons.search, color: Colors.black),
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
                                Icon(Icons.filter_list, color: Colors.black),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          getSaleImages(),
                          // Container(
                          //   width: 330,
                          //   height: 180,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.all(Radius.circular(20)),
                          //     image: DecorationImage(image: AssetImage("assets/images/shoe_discount1.png"),
                          //     fit: BoxFit.fill
                          //   ),
                          //   )
                          // ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.86,
                    ),
                    itemCount: allProducts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(id: allProducts[index].id)));
                        },
                        child: Container(
                          // width: 159,
                          // height: 150,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 224, 222, 222),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 21,
                                left: 40,
                                right: 45,
                                child: Image.network(
                                  allProducts[index].image,
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 36,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.orange[400],
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomLeft: Radius.circular(10))),
                                  child: Center(
                                    child: Icon(Icons.favorite_border,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 140,
                                left: 10,
                                child: Container(
                                  width: 120,
                                  height: 20,
                                  child: Text(allProducts[index].title,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                              ),
                              Positioned(
                                top: 161,
                                left: 10,
                                child: Text(
                                    "\$ ${allProducts[index].price.toString()}",
                                    style: TextStyle(color: Colors.grey)),
                              ),
                              Positioned(
                                top: 166,
                                left: 87,
                                child: Row(
                                  children: [
                                    _colorDot(Colors.black),
                                    _colorDot(Colors.red),
                                    _colorDot(Colors.orange),
                                    _colorDot(Colors.blue),
                                  ],
                                ),
                              )
                            ],
                          ),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailScreen(
                                                id: product.id
                                                  )));
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

  Widget _colorDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
final PageController _controller = PageController();
  Widget getSaleImages(){
    return Stack(
  alignment: Alignment.bottomCenter,
  children: [
    SizedBox(
      height: 180,
        // decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.all(Radius.circular(20)),
        // ),
      child: PageView(
        controller: _controller,
        children: [
          // Image.asset("assets/images/shoe_discount1.png", fit: BoxFit.fill),
          // Image.asset("assets/images/shoe_sale.png", fit: BoxFit.fill),
          Container(
                            width: 330,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(image: AssetImage("assets/images/shoe_discount1.png"),
                              fit: BoxFit.fill
                            ),
                            )
                          ),
                           Container(
                            width: 330,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(image: AssetImage("assets/images/sale.png.avif"),
                              fit: BoxFit.fill
                            ),
                            )
                          ),
                             Container(
                            width: 330,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(image: AssetImage("assets/images/tshirt.avif"),
                              fit: BoxFit.fill
                            ),
                            )
                          ),
        ],
      ),
    ),
    Positioned(
      bottom: 12,
      child: SmoothPageIndicator(
        controller: _controller,
        count: 3,
        effect: WormEffect(
          activeDotColor: Colors.black,
          dotColor: Colors.grey.shade400,
          dotHeight: 10,
          dotWidth: 10,
        ),
      ),
    ),
  ],
);
  }
}
