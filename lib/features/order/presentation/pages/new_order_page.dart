import 'package:app/features/order/presentation/widgets/phone_order_grid.dart';
import 'package:flutter/material.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    int phoneWidth = 1080;

    // Widget layout = screenSize > phoneWidth ? :
    return const Scaffold(
      body: Center(child: PhoneOrderGrid()),
    );
  }
}
