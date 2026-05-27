import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizzeria/models/pizza_model.dart';

class CartItem {
  final PizzaModel pizza;
  int quantity;
  CartItem({required this.pizza, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {
      'name': pizza.name,
      'description': pizza.description,
      'price': pizza.price,
      'imageUrl': pizza.imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      pizza: PizzaModel(
        name: json['name'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
      ),
      quantity: json['quantity'],
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('cart_items');

    if (jsonString != null) {
      final List<dynamic> decodetList = jsonDecode(jsonString);
      state = decodetList.map((item) => CartItem.fromJson(item)).toList();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(
      state.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('cart_items', jsonString);
  }

  void addToCart(PizzaModel pizza) {
    final existingIndex = state.indexWhere(
      (item) => item.pizza.name == pizza.name,
    );
    if (existingIndex != -1) {
      final newState = [...state];
      newState[existingIndex].quantity++;
      state = newState;
    } else {
      state = [...state, CartItem(pizza: pizza)];
    }
    _saveCart();
  }

  void removeFromCart(String name) {
    state = state.where((item) => item.pizza.name != name).toList();
    _saveCart();
  }

  void clearCart() {
    state = [];
    _saveCart();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
