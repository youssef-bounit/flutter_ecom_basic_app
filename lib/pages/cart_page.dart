import 'package:flutter/material.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: appState.cart.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: appState.cart.length,
              itemBuilder: (context, index) {
                int productIndex = appState.cart[index];
                return ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Product $productIndex'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => appState.removeFromCart(productIndex),
                  ),
                );
              },
            ),
    );
  }
}
