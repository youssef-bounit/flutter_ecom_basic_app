import 'package:flutter/material.dart';
import '../models/product.dart';

class AppState extends ChangeNotifier {
  final List<Product> cart = [];
  final List<Product> favorites = [];

  void addToCart(Product product) {
    if (!cart.contains(product)) {
      cart.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    cart.remove(product);
    notifyListeners();
  }

  void addToFavorites(Product product) {
    if (!favorites.contains(product)) {
      favorites.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    favorites.remove(product);
    notifyListeners();
  }

  bool isInCart(Product product) {
    return cart.contains(product);
  }

  bool isInFavorites(Product product) {
    return favorites.contains(product);
  }
}
