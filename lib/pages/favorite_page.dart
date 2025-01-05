import 'package:flutter/material.dart';
import 'package:flutter_ecom_basic_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import '../models/product.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
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
        child: appState.favorites.isEmpty
            ? const Center(child: Text('No favorite items yet'))
            : ListView.builder(
                itemCount: appState.favorites.length,
                itemBuilder: (context, index) {
                  final Product product = appState.favorites[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style:
                                      const TextStyle(color: hevyYellowColor),
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
                                appState.removeFromFavorites(product);
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
    );
  }
}
