import "package:app/core/errors/failure.dart";
import "package:app/core/params/params.dart";
import "package:app/features/displayMenuItems/business/entities/menu_item_entity.dart";
import "package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart";
import "package:app/features/displayMenuItems/presentation/providers/menu_item_type_provider.dart";
import "package:app/features/order/presentation/providers/new_order_provider.dart";
import "package:app/features/order/presentation/widgets/menu_item_card.dart";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

class PhoneMenuItemGrid extends StatefulWidget {
  const PhoneMenuItemGrid({super.key});

  @override
  _PhoneMenuItemGridState createState() => _PhoneMenuItemGridState();
}

class _PhoneMenuItemGridState extends State<PhoneMenuItemGrid> {
  @override
  void initState() {
    super.initState();

    int? selectedTypeId =
        Provider.of<MenuItemTypesProvider>(context, listen: false)
            .selectedTypeId;
    if (selectedTypeId == null) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Failure? failure =
        Provider.of<MenuItemTypesProvider>(context, listen: true).failure;
    List<MenuItemEntity>? menuItems =
        Provider.of<MenuItemTypesProvider>(context, listen: true).menuItems;
    String? selectedTypeName =
        Provider.of<MenuItemTypesProvider>(context, listen: true)
            .selectedTypeName;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedTypeName ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                // dynamic list of menu items
                if (menuItems != null)
                  for (MenuItemEntity menuItem in menuItems)
                    CustomCard(
                      text: menuItem.name,
                      onPressed: () => {
                        Provider.of<OrderProvider>(context, listen: false)
                            .addMenuItemToOrder(CreateOrderItemParams(
                                menuItemId: menuItem.id, count: 1))
                      },
                    ),
                if (failure != null)
                  Text(
                    failure.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
