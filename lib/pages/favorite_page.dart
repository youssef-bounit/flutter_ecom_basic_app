import 'package:flutter/material.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: appState.favorites.isEmpty
          ? Center(child: Text('No favorite items yet'))
          : ListView.builder(
              itemCount: appState.favorites.length,
              itemBuilder: (context, index) {
                int productIndex = appState.favorites[index];
                return ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Product $productIndex'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => appState.removeFromFavorites(productIndex),
                  ),
                );
              },
            ),
    );
  }
}
