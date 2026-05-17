import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzeria/data/pizza_data.dart';
import 'package:pizzeria/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PIZZERIA'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go('/cart'),
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pizzaList.length,
        itemBuilder: (context, index) {
          final pizza = pizzaList[index];
          return Card(
            child: Stack(
              children: [
                Row(
                  children: [
                    Image.network(
                      pizza.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pizza.name),
                            Text(pizza.description),
                            Text('\$${pizza.price}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(pizza);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${pizza.name} added to cart!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: Icon(Icons.add_shopping_cart),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
