class PizzaModel {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const PizzaModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  PizzaModel copyWith({
    String? name,
    String? description,
    double? price,
    String? imageUrl,
  }) {
    return PizzaModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory PizzaModel.fromJson(Map<String, dynamic> json) {
    return PizzaModel(
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
