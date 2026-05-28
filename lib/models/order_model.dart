import 'package:pizzeria/models/pizza_model.dart';

class OrderItem {
  final String id;
  final List<PizzaModel> pizzas;
  final double totalPrice;
  final DateTime dateTime;
  final String status;

  OrderItem({
    required this.id,
    required this.pizzas,
    required this.totalPrice,
    required this.dateTime,
    this.status = 'Preparing',
  });
}
