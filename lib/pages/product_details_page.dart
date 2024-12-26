import 'package:flutter/material.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final int index;

  ProductDetailsPage({required this.index});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product $index',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Price: \$${(index + 1) * 10}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => appState.addToCart(index),
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
