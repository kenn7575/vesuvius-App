import 'package:app/core/errors/failure.dart';
import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/order/presentation/providers/new_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  final String? orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  initState() {
    final provider = Provider.of<OrderProvider>(context, listen: false);
    if (provider.isNewOrder) {
      provider.setIsNewOrder(false);
    } else {
      provider.eitherFailureOrOrder(
          orderId: widget.orderId ?? "order id not found");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isNewOrder =
        Provider.of<OrderProvider>(context, listen: true).isNewOrder;
    OrderEntity? orderEntity =
        Provider.of<OrderProvider>(context, listen: true).orderEntity;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Confirmed'),
        leading: BackButton(
          onPressed: () {
            GoRouter.of(context).go('/orders/itemTypes');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Menu genstande",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: orderEntity == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: orderEntity.orderItems?.length,
                      itemBuilder: (context, index) {
                        final item = orderEntity.orderItems?[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown[200],
                            child: Text(item?.quantity.toString() ?? "?"),
                          ),
                          title: Text(
                              item?.menuItemId.toString() ?? "No item name"),
                        );
                      },
                    ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              "Borde: ${orderEntity?.tablesAsString}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              "Status: ${orderEntity?.status}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              "Kommentar: ${orderEntity?.comment}",
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
