import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle loginTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -0.5,
  );

  static const TextStyle loginSubtitle = TextStyle(
    fontSize: 15,
    color: AppColors.greyText,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: AppColors.onSurface,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 13,
    color: AppColors.grey600,
  );

  static const TextStyle pizzaPrice = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.accent,
  );

  static const TextStyle cartTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  static const TextStyle emptyState = TextStyle(
    fontSize: 18,
    color: AppColors.greyText,
  );

  static const TextStyle orderTotal = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.accent,
  );

  static const TextStyle profileTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle profileSubtitle = TextStyle(
    fontSize: 18,
    color: AppColors.greyText,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle historySubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.greyText,
  );

  static const TextStyle orderAmount = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static const TextStyle deliveredLabel = TextStyle(
    color: AppColors.success,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
}