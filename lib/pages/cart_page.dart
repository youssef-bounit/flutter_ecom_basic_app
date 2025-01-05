import 'package:flutter/material.dart';
import 'package:flutter_ecom_basic_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import '../models/product.dart';
import 'package:hugeicons/hugeicons.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    double total = 0;
    appState.cart.forEach((product, quantity) {
      total += product.price * quantity;
    });
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: lightWhiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Container(
        color: lightWhiteColor,
        child: appState.cart.isEmpty
            ? const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: appState.cart.length,
                      itemBuilder: (context, index) {
                        final entry = appState.cart.entries.elementAt(index);
                        final Product product = entry.key;
                        final int quantity = entry.value;

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: greyColor,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.asset(
                                    'assets/${product.image}',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name.length > 15
                                            ? '${product.name.substring(0, 15)}...'
                                            : product.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: hevyYellowColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(9)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            appState.decrementQuantity(product);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: Colors.white,
                                            foregroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                          child: const Icon(Icons.remove,
                                              size: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Text(
                                          quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            appState.incrementQuantity(product);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: Colors.white,
                                            foregroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                          child:
                                              const Icon(Icons.add, size: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      appState.removeFromCart(product);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: deleteRed,
                                      foregroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            appState.clearCart();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Checkout',
                                    style: TextStyle(fontSize: 22)),
                                const SizedBox(width: 20),
                                Container(
                                  width: width * 0.076,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const HugeIcon(
                                    icon: HugeIcons
                                        .strokeRoundedShoppingCartCheck01,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
