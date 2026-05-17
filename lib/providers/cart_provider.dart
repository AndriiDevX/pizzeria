import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizzeria/models/pizza_model.dart';

class CartNotifier extends StateNotifier<List<PizzaModel>> {
  CartNotifier() : super([]);
  void addToCart(PizzaModel pizza) {
    state = [...state, pizza];
  }

  void removeFromCart(String name) {
    state = state.where((n) => n.name != name).toList();
  }

  void clearCart(){
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<PizzaModel>>(
  (ref) => CartNotifier(),
);
