import 'package:flutter/material.dart';
import '../models/product.dart';

class AppState extends ChangeNotifier {
  final Map<Product, int> cart = {};
  final List<Product> favorites = [];

  void addToCart(Product product, [int quantity = 1]) {
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + quantity;
    } else {
      cart[product] = quantity;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    cart.remove(product);
    notifyListeners();
  }

  void updateCartQuantity(Product product, int quantity) {
    if (quantity > 0) {
      cart[product] = quantity;
    } else {
      cart.remove(product);
    }
    notifyListeners();
  }

  void incrementQuantity(Product product) {
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + 1;
    } else {
      cart[product] = 1;
    }
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    if (cart.containsKey(product) && cart[product]! > 1) {
      cart[product] = cart[product]! - 1;
    } else {
      cart.remove(product);
    }
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (isInFavorites(product)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
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
    return cart.containsKey(product);
  }

  bool isInFavorites(Product product) {
    return favorites.contains(product);
  }

  int getCartQuantity(Product product) {
    return cart[product] ?? 0;
  }

  double getCartTotalPrice() {
    return cart.entries
        .map((entry) => entry.key.price * entry.value)
        .fold(0.0, (sum, item) => sum + item);
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}
