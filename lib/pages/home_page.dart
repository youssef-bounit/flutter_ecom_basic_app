import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecom_basic_app/constants/colors.dart';
import 'product_details_page.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _loadProducts();
  }

  Future<List<Product>> _loadProducts() async {
    final String response =
        await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightWhiteColor,
        elevation: 0.1,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedDashboardSquare01,
            color: primaryColor,
            size: 24,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        color: lightWhiteColor,
        child: FutureBuilder<List<Product>>(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading products'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            final products = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: product),
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      color: greyColor,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/${product.image}',
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.8),
                                  child: Text(
                                    '\$${product.price}',
                                    style: const TextStyle(
                                        fontSize: 14, color: yellowColor),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      appState.toggleFavorite(product);
                                    },
                                    icon: HugeIcon(
                                      icon: HugeIcons.strokeRoundedFavourite,
                                      color: appState.isInFavorites(product)
                                          ? Colors.red
                                          : primaryColor,
                                      size: 22,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      appState.addToCart(product);
                                    },
                                    icon: const HugeIcon(
                                      icon: HugeIcons
                                          .strokeRoundedShoppingCartCheckIn01,
                                      color: primaryColor,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(1, 1),
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${product.rating}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'cart',
            backgroundColor: primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingCart01,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'favorites',
            backgroundColor: primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritePage()),
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedFavourite,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
