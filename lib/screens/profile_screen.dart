import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizzeria/core/app_colors.dart';
import 'package:pizzeria/core/app_strings.dart';
import 'package:pizzeria/core/app_text_styles.dart';
import 'package:pizzeria/providers/order_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    final orderHistory = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.profileTitle,
          style: AppTextStyles.sectionTitle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            user?.displayName ?? AppStrings.guestUser,
            style: AppTextStyles.profileTitle,
          ),
          const SizedBox(height: 8),
          Text(
            user?.email ?? AppStrings.noEmailAvailable,
            style: AppTextStyles.profileSubtitle,
          ),
          const SizedBox(height: 20),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redAccent,
              foregroundColor: AppColors.surface,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text(AppStrings.logout),
          ),

          const SizedBox(height: 30),
          const Divider(thickness: 1, indent: 20, endIndent: 20),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${AppStrings.orderHistoryLabel} (${orderHistory.length})',
                style: AppTextStyles.sectionTitle,
              ),
            ),
          ),

          Expanded(
            child: orderHistory.isEmpty
                ? const Center(
                    child: Text(
                      AppStrings.orderHistoryEmpty,
                      style: AppTextStyles.historySubtitle,
                    ),
                  )
                : ListView.builder(
                    itemCount: orderHistory.length,
                    itemBuilder: (context, index) {
                      final order = orderHistory[index];

                      final orderTime =
                          "${order.dateTime.day}/${order.dateTime.month} ${order.dateTime.hour}:${order.dateTime.minute.toString().padLeft(2, '0')}";

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            AppStrings.orderNumber(order.id),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${AppStrings.orderDate} $orderTime'),
                              Text(
                                'Items: ${order.items.map((p) => p.pizza.name).join(', ')}',
                                style: const TextStyle(color: AppColors.onSurface),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${order.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                AppStrings.delivered,
                                style: AppTextStyles.deliveredLabel,
                              ),
                            ],
                          ),
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
