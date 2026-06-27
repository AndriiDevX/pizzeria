import 'package:pizzeria/providers/cart_provider.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime dateTime;

  const OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });

  OrderModel copyWith({
    String? id,
    List<CartItem>? items,
    double? totalAmount,
    DateTime? dateTime,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime'] as String),
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
