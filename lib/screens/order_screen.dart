import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            Text('Order placed successfully!'),
            Text('Expected delivery: 30-45 minutes'),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text('Back to menu'),
            ),
          ],
        ),
      ),
    );
  }
}
