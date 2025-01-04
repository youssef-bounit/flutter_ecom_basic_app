import 'package:flutter/material.dart';
import '../models/product.dart';

class AppState extends ChangeNotifier {
  final Map<Product, int> cart = {}; // Map to store products with quantities
  final List<Product> favorites = [];

  // Add a product to the cart or update its quantity
  void addToCart(Product product, [int quantity = 1]) {
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + quantity;
    } else {
      cart[product] = quantity;
    }
    notifyListeners();
  }

  // Remove a product from the cart
  void removeFromCart(Product product) {
    cart.remove(product);
    notifyListeners();
  }

  // Update product quantity in the cart
  void updateCartQuantity(Product product, int quantity) {
    if (quantity > 0) {
      cart[product] = quantity;
    } else {
      cart.remove(product); // Remove the product if quantity is zero
    }
    notifyListeners();
  }

  // Increment product quantity in the cart
  void incrementQuantity(Product product) {
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + 1;
    } else {
      cart[product] =
          1; // Add the product with a quantity of 1 if not in the cart
    }
    notifyListeners();
  }

  // Decrement product quantity in the cart
  void decrementQuantity(Product product) {
    if (cart.containsKey(product) && cart[product]! > 1) {
      cart[product] = cart[product]! - 1;
    } else {
      cart.remove(product); // Remove the product if quantity becomes zero
    }
    notifyListeners();
  }

  // Toggle a product in the favorites list (add/remove)
  void toggleFavorite(Product product) {
    if (isInFavorites(product)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
  }

  // Add a product to the favorites list
  void addToFavorites(Product product) {
    if (!favorites.contains(product)) {
      favorites.add(product);
      notifyListeners();
    }
  }

  // Remove a product from the favorites list
  void removeFromFavorites(Product product) {
    favorites.remove(product);
    notifyListeners();
  }

  // Check if a product is in the cart
  bool isInCart(Product product) {
    return cart.containsKey(product);
  }

  // Check if a product is in the favorites list
  bool isInFavorites(Product product) {
    return favorites.contains(product);
  }

  // Get the quantity of a product in the cart
  int getCartQuantity(Product product) {
    return cart[product] ?? 0;
  }

  // Calculate the total price of the cart
  double getCartTotalPrice() {
    return cart.entries
        .map((entry) => entry.key.price * entry.value)
        .fold(0.0, (sum, item) => sum + item);
  }
}
