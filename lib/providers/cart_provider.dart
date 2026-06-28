import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizzeria/models/pizza_model.dart';

class CartItem {
  final PizzaModel pizza;
  final int quantity;

  const CartItem({required this.pizza, this.quantity = 1});

  CartItem copyWith({PizzaModel? pizza, int? quantity}) {
    return CartItem(
      pizza: pizza ?? this.pizza,
      quantity: quantity ?? this.quantity,
    );
  }

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
        name: json['name'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'] as String,
      ),
      quantity: json['quantity'] as int,
    );
  }
}

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    _loadCart();
    return const [];
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('cart_items');

    if (jsonString != null) {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      state = decodedList
          .cast<Map<String, dynamic>>()
          .map((item) => CartItem.fromJson(item))
          .toList();
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
      final existingItem = newState[existingIndex];
      newState[existingIndex] =
          existingItem.copyWith(quantity: existingItem.quantity + 1);
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
    state = const [];
    _saveCart();
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);
