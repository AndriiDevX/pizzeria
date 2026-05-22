import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizzeria/models/pizza_model.dart';

class CartItem {
  final PizzaModel pizza;
  int quantity;
  CartItem({required this.pizza, this.quantity = 1});
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);
  void addToCart(PizzaModel pizza) {
    final existingIndex = state.indexWhere((item) => item.pizza.name == pizza.name);
    if (existingIndex != -1){
      final newState = [...state];
      newState[existingIndex].quantity++;
      state = newState;
    }else{
      state = [...state, CartItem(pizza: pizza)];
    }
  }

  void removeFromCart(String name) {
    state = state.where((item) => item.pizza.name != name).toList();
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
