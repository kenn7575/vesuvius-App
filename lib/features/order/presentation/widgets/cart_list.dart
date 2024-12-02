import 'package:app/core/params/params.dart';
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
  List<CreateOrderItemParams> _items = [];
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
    _items = List.from(_provider.createOrderParams?.menuItems ?? []);
  }

  void _onProviderUpdate() {
    final newItems = _provider.createOrderParams?.menuItems ?? [];
    _updateItems(newItems);
  }

  void _updateItems(List<CreateOrderItemParams> newItems) {
    final oldItems = _items;
    final oldIds = oldItems.map((item) => item.menuItemId).toSet();
    final newIds = newItems.map((item) => item.menuItemId).toSet();

    // Items to remove
    for (int i = oldItems.length - 1; i >= 0; i--) {
      if (!newIds.contains(oldItems[i].menuItemId)) {
        final removedItem = _items.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildItem(context, removedItem, animation),
        );
      }
    }

    // Items to add
    for (int i = 0; i < newItems.length; i++) {
      if (!oldIds.contains(newItems[i].menuItemId)) {
        _items.insert(i, newItems[i]);
        _listKey.currentState?.insertItem(i);
      } else {
        // Update existing item if necessary
        if (newItems[i] != _items[i]) {
          setState(() {
            _items[i] = newItems[i];
          });
        }
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
    CreateOrderItemParams item,
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
              Text('Quantity: ${item.count}'),
              if (item.comment != null) Text('Comment: ${item.comment}'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  final provider =
                      Provider.of<OrderProvider>(context, listen: false);
                  if (item.count > 1) {
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
                    CreateOrderItemParams(
                      menuItemId: item.menuItemId,
                      count: 1,
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
    CreateOrderItemParams item,
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
              final updatedItem = CreateOrderItemParams(
                menuItemId: item.menuItemId,
                count: item.count,
                comment: controller.text,
              );
              provider.commentOnOrderItem(updatedItem);
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
        final items = provider.createOrderParams?.menuItems ?? [];

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
