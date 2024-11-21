import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget layout = screenSize > phoneWidth ? :
    return Scaffold(
        body: Center(
            child: MaterialButton(
      onPressed: () => context.go("/order"),
      child: const Text("back"),
    )));
  }
}
