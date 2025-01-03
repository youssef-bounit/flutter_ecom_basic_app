import 'package:flutter/material.dart';
import 'package:flutter_ecom_basic_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: lightWhiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust the margin as needed
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.white), // Change icon color if needed
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back when pressed
              },
            ),
          ),
        ),
      ),
      body: Container(
        color: lightWhiteColor, // Set your desired background color here
        child: appState.cart.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : ListView.builder(
                itemCount: appState.cart.length,
                itemBuilder: (context, index) {
                  final Product product = appState.cart[index];
                  return ListTile(
                    leading: const Icon(
                        Icons.image), // Replace with product image if available
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: Container(
                      decoration: BoxDecoration(
                        color: Colors
                            .red, // Set your desired background color here
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add rounded corners
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.white), // Change icon color if needed
                        onPressed: () => appState.removeFromCart(product),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
