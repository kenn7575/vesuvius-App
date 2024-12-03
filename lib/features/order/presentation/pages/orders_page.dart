import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget layout = screenSize > phoneWidth ? :
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              FilledButton(
                onPressed: () => context.go("/orders/table"),
                child: const Text("Ny ordre"),
              ),
              FilledButton(
                onPressed: () => context.go("/orders/confirm"),
                child: const Text("Se confirmation"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
