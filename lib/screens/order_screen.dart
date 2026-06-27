import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzeria/core/app_colors.dart';
import 'package:pizzeria/core/app_strings.dart';
import 'package:pizzeria/core/app_text_styles.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 100),
            const SizedBox(height: 16),
            const Text(
              AppStrings.orderPlaced,
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.expectedDelivery,
              style: AppTextStyles.historySubtitle,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.surface,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: const Text(AppStrings.backToMenu),
            ),
          ],
        ),
      ),
    );
  }
}
