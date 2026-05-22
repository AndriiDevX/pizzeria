import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzeria/providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartPizzas = ref.watch(cartProvider);
    final total = cartPizzas.fold(
      0.0,
      (sum, item) => sum + (item.pizza.price * item.quantity),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        itemCount: cartPizzas.length,
        itemBuilder: (context, index) {
          final cartPizza = cartPizzas[index];
          return Card(
            child: Stack(
              children: [
                Row(
                  children: [
                    Image.network(
                      cartPizza.pizza.imageUrl,
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
                            Text(
                              cartPizza.pizza.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cartPizza.pizza.description,
                              style: TextStyle(color: Colors.grey),
                            ),

                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text('\$${cartPizza.pizza.price}'),
                                const SizedBox(width: 15,),
                                Text(
                                  'x${cartPizza.quantity}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
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
                      ref
                          .read(cartProvider.notifier)
                          .removeFromCart(cartPizza.pizza.name);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Total: \$$total',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
                context.go('/order');
              },
              child: Text('order'),
            ),
          ),
        ],
      ),
    );
  }
}
