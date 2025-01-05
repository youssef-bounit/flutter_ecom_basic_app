import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecom_basic_app/constants/colors.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'app_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  void showSnackbar(
      BuildContext context, String message, VoidCallback undoCallback) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primaryColor,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: undoCallback,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(fontSize: 20),
        ),
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
      backgroundColor: lightWhiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: height,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: width * 0.8,
                      child: Image.asset(
                        'assets/${widget.product.image}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: \$${widget.product.price}',
                    style:
                        const TextStyle(fontSize: 18, color: hevyYellowColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description: ${widget.product.description}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: greyColor,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(6),
                      alignment: Alignment.center,
                      child: Text(
                        'Total: \$${(widget.product.price * quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, color: hevyYellowColor),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      child: Row(
                        children: [
                          quantity > 1
                              ? SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: quantity > 1
                                        ? () => setState(() => quantity--)
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.white,
                                      foregroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    child: const Icon(Icons.remove, size: 18),
                                  ),
                                )
                              : const SizedBox(width: 0, height: 0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                              onPressed: () => setState(() => quantity++),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.white,
                                foregroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              child: const Icon(Icons.add, size: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 59.5,
                        child: ElevatedButton(
                          onPressed: () {
                            appState.addToFavorites(widget.product);
                            showSnackbar(context,
                                "${widget.product.name} added to Favorites!",
                                () {
                              appState.removeFromFavorites(widget.product);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side:
                                const BorderSide(color: primaryColor, width: 2),
                            elevation: 0,
                          ),
                          child: Icon(
                            appState.isInFavorites(widget.product)
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: appState.isInFavorites(widget.product)
                                ? Colors.red
                                : primaryColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 7,
                      child: ElevatedButton(
                        onPressed: () {
                          appState.addToCart(widget.product, quantity);
                          showSnackbar(
                              context, "${widget.product.name} added to Cart!",
                              () {
                            appState.removeFromCart(widget.product);
                          });
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
                              const Text('Add to Cart'),
                              const SizedBox(width: 20),
                              Container(
                                width: width * 0.075,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const HugeIcon(
                                  icon: HugeIcons
                                      .strokeRoundedShoppingCartCheckIn01,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
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
