import 'package:app/features/order/presentation/providers/new_order_provider.dart';
import 'package:app/features/order/presentation/widgets/cart_list.dart';
import 'package:app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartSheet extends StatefulWidget {
  const CartSheet({super.key});

  @override
  State<CartSheet> createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  final double snapPositionBottom = 0.15;
  final double snapPositionHalf = 0.4;
  final double snapPositionFull = 0.85;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: snapPositionBottom,
      minChildSize: snapPositionBottom,
      maxChildSize: snapPositionFull,
      snap: true,
      snapSizes: [snapPositionBottom, snapPositionHalf, snapPositionFull],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag Handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const OrderItemsList(),
                  ],
                ),
              ),
              // Order Items List
              SliverFillRemaining(
                hasScrollBody: true,
                fillOverscroll: false,
                child: Consumer<OrderProvider>(
                  builder: (context, provider, child) {
                    if (provider.createOrderParams?.orderItems.isEmpty ??
                        true) {
                      return const Center(
                        child: Text('No items in cart'),
                      );
                    }

                    return Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // get the user id
                                    final userProvider =
                                        Provider.of<UserProvider>(context,
                                            listen: false);
                                    final userId = userProvider.user?.id;

                                    // set the waiter id
                                    provider.createOrderParams?.waiterId =
                                        userId;

                                    await provider.placeOrderOrFailure();
                                    if (provider.orderEntity != null) {
                                      if (context.mounted) {
                                        context.go(
                                            "/orders/${provider.orderEntity?.id}");
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Failed to place order. Please try again.'),
                                          ),
                                        );
                                      }
                                    }
                                    if (context.mounted) {
                                      context.go(
                                          "/orders/${provider.orderEntity?.id}");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  child: const Text('Place Order'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
