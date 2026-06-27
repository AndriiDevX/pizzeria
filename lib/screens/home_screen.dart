import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzeria/core/app_colors.dart';
import 'package:pizzeria/core/app_strings.dart';
import 'package:pizzeria/core/app_text_styles.dart';
import 'package:pizzeria/data/pizza_data.dart';
import 'package:pizzeria/providers/cart_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredPizzas = pizzaList.where((pizza) {
      return pizza.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            context.push('/profile');
          },
          icon: const Icon(Icons.person, color: AppColors.onSurface, size: 28),
        ),
        title: const Text(
          AppStrings.appTitle,
          style: AppTextStyles.appBarTitle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go('/cart'),
            icon: const Icon(
              Icons.shopping_cart,
              color: AppColors.onSurface,
              size: 26,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: AppStrings.searchHint,
                  hintStyle: TextStyle(color: AppColors.grey400),
                  prefixIcon: Icon(Icons.search, color: AppColors.accent),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPizzas.length,
              itemBuilder: (context, index) {
                final pizza = filteredPizzas[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            pizza.imageUrl,
                            width: 105,
                            height: 105,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 12.0,
                            top: 12,
                            bottom: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pizza.name,
                                style: AppTextStyles.cardTitle,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pizza.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.cardDescription,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${pizza.price}',
                                    style: AppTextStyles.pizzaPrice,
                                  ),
                                  Material(
                                    color: AppColors.accentLight,
                                    shape: const CircleBorder(),
                                    child: IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.all(8),
                                      icon: const Icon(
                                        Icons.add_shopping_cart,
                                        color: AppColors.accent,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        ref.read(cartProvider.notifier).addToCart(pizza);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(AppStrings.addedToCart(pizza.name)),
                                            duration: const Duration(seconds: 1),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: AppColors.accent,
                                          ),
                                        );
                                      },
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
