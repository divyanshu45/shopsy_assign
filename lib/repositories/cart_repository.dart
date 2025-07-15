import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartRepository {
  static const String _cartKey = 'cart_items';
  
  Future<List<CartItem>> getCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cartJson = prefs.getString(_cartKey);
      
      if (cartJson == null) return [];
      
      final List<dynamic> cartData = json.decode(cartJson);
      return cartData.map((json) => CartItem.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load cart items: $e');
    }
  }

  Future<void> saveCartItems(List<CartItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String cartJson = json.encode(items.map((item) => item.toJson()).toList());
      await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      throw Exception('Failed to save cart items: $e');
    }
  }

  Future<void> addToCart(Product product, int quantity) async {
    try {
      final cartItems = await getCartItems();
      final existingIndex = cartItems.indexWhere((item) => item.product.id == product.id);
      
      if (existingIndex >= 0) {
        cartItems[existingIndex] = cartItems[existingIndex].copyWith(
          quantity: cartItems[existingIndex].quantity + quantity,
        );
      } else {
        cartItems.add(CartItem(product: product, quantity: quantity));
      }
      
      await saveCartItems(cartItems);
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> removeFromCart(int productId) async {
    try {
      final cartItems = await getCartItems();
      cartItems.removeWhere((item) => item.product.id == productId);
      await saveCartItems(cartItems);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      final cartItems = await getCartItems();
      final index = cartItems.indexWhere((item) => item.product.id == productId);
      
      if (index >= 0) {
        if (quantity <= 0) {
          cartItems.removeAt(index);
        } else {
          cartItems[index] = cartItems[index].copyWith(quantity: quantity);
        }
        await saveCartItems(cartItems);
      }
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  Future<int> getCartItemCount() async {
    try {
      final cartItems = await getCartItems();
      return cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
    } catch (e) {
      return 0;
    }
  }

  Future<double> getCartTotal() async {
    try {
      final cartItems = await getCartItems();
      return cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
    } catch (e) {
      return 0.0;
    }
  }
}