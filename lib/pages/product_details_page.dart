import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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
  int quantity = 1; // Initial quantity

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
          onPressed: () {
            undoCallback(); // Call the undo action
          },
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            // Quantity adjustment buttons
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red),
                  onPressed:
                      quantity > 1 ? () => setState(() => quantity--) : null,
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: () => setState(() => quantity++),
                ),
              ],
            ),
          ],
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
                    child: Container(
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
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description: ${widget.product.description}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      'Total: \$${(widget.product.price * quantity).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, color: Colors.blue)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(width: 2),
                    ),
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        appState.addToFavorites(widget.product);
                        showSnackbar(context,
                            "${widget.product.name} added to Favorites!", () {
                          appState.removeFromFavorites(widget.product);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightWhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const HugeIcon(
                        icon: HugeIcons.strokeRoundedFavourite,
                        color: primaryColor,
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
                          context, "${widget.product.name} added to Cart!", () {
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
                              icon:
                                  HugeIcons.strokeRoundedShoppingCartCheckIn01,
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
          ),
        ],
      ),
    );
  }
}
