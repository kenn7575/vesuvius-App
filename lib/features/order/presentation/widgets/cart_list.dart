import 'package:app/features/order/data/models/params/create_order_item_params_model.dart';
import 'package:app/features/order/presentation/providers/new_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItemsList extends StatefulWidget {
  const OrderItemsList({super.key});

  @override
  State<OrderItemsList> createState() => _OrderItemsListState();
}

class _OrderItemsListState extends State<OrderItemsList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<CreateOrderItemParamsModel> _items = [];
  late OrderProvider _provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = Provider.of<OrderProvider>(context);
    _provider.addListener(_onProviderUpdate);
    _items = List.from(_provider.createOrderParams?.orderItems ?? []);
  }

  void _onProviderUpdate() {
    final newItems = _provider.createOrderParams?.orderItems ?? [];
    _updateItems(newItems);
  }

  void _updateItems(List<CreateOrderItemParamsModel> newItems) {
    final oldItems = List<CreateOrderItemParamsModel>.from(_items);

    // Remove items not in newItems
    for (int i = oldItems.length - 1; i >= 0; i--) {
      final oldItem = oldItems[i];
      if (!newItems.contains(oldItem)) {
        final removedItem = _items.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildItem(context, removedItem, animation),
        );
      }
    }

    // Add items not in oldItems
    for (int i = 0; i < newItems.length; i++) {
      final newItem = newItems[i];
      if (i >= _items.length || _items[i] != newItem) {
        _items.insert(i, newItem);
        _listKey.currentState?.insertItem(i);
      } else if (_items[i] != newItem) {
        // Update existing item if necessary
        setState(() {
          _items[i] = newItem;
        });
      }
    }
  }

  @override
  void dispose() {
    _provider.removeListener(_onProviderUpdate);
    super.dispose();
  }

  Widget _buildItem(
    BuildContext context,
    CreateOrderItemParamsModel item,
    Animation<double> animation,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          title: Text('Item ID: ${item.menuItemId}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quantity: ${item.quantity}'),
              if (item.comment != null) Text('· ${item.comment}'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    final provider =
                        Provider.of<OrderProvider>(context, listen: false);
                    provider.dublicateOrderItem(item);
                  },
                  icon: const Icon(Icons.copy)),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  final provider =
                      Provider.of<OrderProvider>(context, listen: false);
                  if (item.quantity > 1) {
                    provider.subtractQuantity(item);
                  } else {
                    provider.removeMenuItemFromOrder(item);
                  }
                  // No need to call removeItem here; it's handled in _updateItems
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  final provider =
                      Provider.of<OrderProvider>(context, listen: false);
                  provider.addMenuItemToOrder(
                    CreateOrderItemParamsModel(
                      menuItemId: item.menuItemId,
                      quantity: 1,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  final provider =
                      Provider.of<OrderProvider>(context, listen: false);
                  _showCommentDialog(context, item, provider);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCommentDialog(
    BuildContext context,
    CreateOrderItemParamsModel item,
    OrderProvider provider,
  ) {
    final controller = TextEditingController(text: item.comment);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter comment',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedItem = CreateOrderItemParamsModel(
                menuItemId: item.menuItemId,
                quantity: item.quantity,
                comment: item.comment,
              );
              provider.commentOnOrderItem(updatedItem, controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, provider, child) {
        final items = provider.createOrderParams?.orderItems ?? [];

        return AnimatedList(
          key: _listKey,
          initialItemCount: items.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index, animation) {
            return _buildItem(context, items[index], animation);
          },
          // Add these properties to help with nested scrolling
          shrinkWrap: true, // Important for nested scrolling
          physics:
              const NeverScrollableScrollPhysics(), // Prevent independent scrolling
        );
      },
    );
  }
}
