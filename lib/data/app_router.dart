import 'package:go_router/go_router.dart';
import 'package:pizzeria/screens/home_screen.dart';
import 'package:pizzeria/screens/cart_screen.dart';
import 'package:pizzeria/screens/order_screen.dart';
import 'package:pizzeria/screens/login_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
    GoRoute(path: '/order', builder: (context, state) => const OrderScreen()),
  ],
);
