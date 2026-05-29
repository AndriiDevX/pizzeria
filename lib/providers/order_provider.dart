import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pizzeria/models/order_model.dart';
import 'cart_provider.dart';

class OrderNotifier extends StateNotifier<List<OrderModel>> {
  OrderNotifier() : super([]) {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ordersJson = prefs.getString('orders_history');

    if (ordersJson != null) {
      final List<dynamic> decodedList = jsonDecode(ordersJson);
      state = decodedList.map((item) => OrderModel.fromJson(item)).toList();
    }
  }

  Future<void> addOrder(List<CartItem> items, double totalAmount) async {
    final newOrder = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: items,
      totalAmount: totalAmount,
      dateTime: DateTime.now(),
    );

    state = [newOrder, ...state];

    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      state.map((e) => e.toJson()).toList(),
    );
    await prefs.setString('orders_history', encodedData);
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, List<OrderModel>>((
  ref,
) {
  return OrderNotifier();
});
