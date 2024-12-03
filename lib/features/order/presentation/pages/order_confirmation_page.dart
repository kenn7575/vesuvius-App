import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderConfirmationPage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {"name": "Cappuccino", "quantity": 2},
    {"name": "Pancakes", "quantity": 1},
    {"name": "Sandwich", "quantity": 3},
  ];

  final String orderStatus =
      "Preparing"; // Possible values: Preparing, Ready, Served
  final String estimatedTime = "15 minutes";
  final String tableNumber = "Table 5";

  OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmation"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.brown[200],
                      child: Text(item["quantity"].toString()),
                    ),
                    title: Text(item["name"]),
                  );
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              "Table: $tableNumber",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              "Status: $orderStatus",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              "Estimated Time: $estimatedTime",
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Center(
              child: FilledButton(
                onPressed: () => context.go("/orders/confirm"),
                child: const Text("Okay"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
