import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget layout = screenSize > phoneWidth ? :
    return Scaffold(
        appBar: AppBar(
          title: const Text("Vælg borde"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go("/"),
          ),
        ),
        body: Center(
            child: MaterialButton(
          onPressed: () => context.go("/order/table"),
          child: const Text("itemTypes ->"),
        )));
  }
}
