import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget layout = screenSize > phoneWidth ? :
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () => context.go("/orders/table"),
          child: const Text("itemTypes ->"),
        ),
      ),
    );
  }
}
