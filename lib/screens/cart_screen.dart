import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzeria/core/app_colors.dart';
import 'package:pizzeria/core/app_strings.dart';
import 'package:pizzeria/core/app_text_styles.dart';
import 'package:pizzeria/providers/cart_provider.dart';
import 'package:pizzeria/providers/order_provider.dart';

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
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          AppStrings.cartTitle,
          style: AppTextStyles.cartTitle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
        ),
      ),
      body: cartPizzas.isEmpty
          ? const Center(
              child: Text(
                AppStrings.cartEmpty,
                style: AppTextStyles.emptyState,
              ),
            )
          : ListView.builder(
              itemCount: cartPizzas.length,
              itemBuilder: (context, index) {
                final cartPizza = cartPizzas[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  cartPizza.pizza.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartPizza.pizza.name,
                                      style: AppTextStyles.cardTitle,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Quantity: ${cartPizza.quantity}',
                                      style: const TextStyle(
                                        color: AppColors.grey600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${(cartPizza.pizza.price * cartPizza.quantity).toStringAsFixed(2)}',
                                      style: AppTextStyles.orderAmount,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .removeFromCart(cartPizza.pizza.name);
                            },
                            icon: const Icon(Icons.delete_outline, color: AppColors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 12),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.totalLabel,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: AppTextStyles.orderTotal,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                onPressed: cartPizzas.isEmpty
                    ? null
                    : () {
                        ref.read(orderProvider.notifier).addOrder(cartPizzas, total);
                        ref.read(cartProvider.notifier).clearCart();
                        context.go('/order');
                      },
                child: const Text(
                  AppStrings.orderNow,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}