import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizzeria/models/order_model.dart';
import 'package:pizzeria/models/pizza_model.dart';
import 'cart_provider.dart';

class OrderNotifier extends StateNotifier<List<OrderItem>> {
  OrderNotifier() : super([]);

  void addOrder(List<dynamic> cartItems, double total) {
    final List<PizzaModel> pizzasFromCart = cartItems
        .map((item) => item.pizza as PizzaModel)
        .toList();
    final newOrder = OrderItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pizzas: pizzasFromCart,
      totalPrice: total,
      dateTime: DateTime.now(),
      status: 'Preparing',
    );
    state = [newOrder, ...state];
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, List<OrderItem>>((
  ref,
) {
  return OrderNotifier();
});
