import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final List<int> cart = [];
  final List<int> favorites = [];

  void addToCart(int index) {
    if (!cart.contains(index)) {
      cart.add(index);
      notifyListeners();
    }
  }

  void removeFromCart(int index) {
    cart.remove(index);
    notifyListeners();
  }

  void addToFavorites(int index) {
    if (!favorites.contains(index)) {
      favorites.add(index);
      notifyListeners();
    }
  }

  void removeFromFavorites(int index) {
    favorites.remove(index);
    notifyListeners();
  }
}
