import 'package:pizzeria/providers/cart_provider.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime dateTime;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      items: (json['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
