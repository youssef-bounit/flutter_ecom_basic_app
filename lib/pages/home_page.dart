import 'package:flutter/material.dart';
import 'product_details_page.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(index: index),
              ),
            ),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Product $index',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('\$${(index + 1) * 10}',
                      style: TextStyle(fontSize: 14, color: Colors.blue)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => appState.addToCart(index),
                        child: Icon(Icons.add_shopping_cart),
                      ),
                      ElevatedButton(
                        onPressed: () => appState.addToFavorites(index),
                        child: Icon(Icons.favorite),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'cart',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            ),
            child: Icon(Icons.shopping_cart),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'favorites',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritePage()),
            ),
            child: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
