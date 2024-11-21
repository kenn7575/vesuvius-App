import "package:app/core/errors/failure.dart";
import "package:app/features/displayMenuItems/business/entities/menu_item_entity.dart";
import "package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart";
import "package:app/features/displayMenuItems/presentation/pages/menu_item_page.dart";
import "package:app/features/displayMenuItems/presentation/providers/menu_item_type_provider.dart";
import "package:app/features/displayMenuItems/presentation/widgets/phone_menu_item_grid.dart";
import "package:app/features/order/presentation/widgets/menu_item_card.dart";
import "package:app/features/order/presentation/widgets/phone_order_grid.dart";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class PhoneMenuItemTypeGrid extends StatefulWidget {
  const PhoneMenuItemTypeGrid({super.key});

  @override
  _PhoneMenuItemTypeGridState createState() => _PhoneMenuItemTypeGridState();
}

class _PhoneMenuItemTypeGridState extends State<PhoneMenuItemTypeGrid> {
  @override
  void initState() {
    super.initState();
    // Call the provider to get menu item types
    if (mounted) {
      Provider.of<MenuItemTypesProvider>(context, listen: false)
          .getMenuItemTypes(); // Replace getMenuItemTypes() with your provider's method
    }
  }

  @override
  Widget build(BuildContext context) {
    Failure? failure =
        Provider.of<MenuItemTypesProvider>(context, listen: true).failure;
    List<MenuItemTypeEntity>? menuItemTypes =
        Provider.of<MenuItemTypesProvider>(context, listen: true).menuItemTypes;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mad',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[
                    // dynamic list of menu items
                    if (menuItemTypes != null)
                      for (MenuItemTypeEntity menuItemType in menuItemTypes
                          .where((menuItem) => menuItem.isFood == true))
                        CustomCard(
                          text: menuItemType.name,
                          onPressed: () => {
                            Provider.of<MenuItemTypesProvider>(
                              context,
                              listen: false,
                            ).setSelectedType(
                                typeId: menuItemType.id,
                                typeName: menuItemType.name),
                            Provider.of<MenuItemTypesProvider>(
                              context,
                              listen: false,
                            ).getMenuItems(typeId: menuItemType.id),
                            context.go("/order/itemTypes/menuItems"),
                          },
                        ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Drikkevarer',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: <Widget>[
                      if (menuItemTypes != null)
                        for (MenuItemTypeEntity menuItemType in menuItemTypes
                            .where((menuItem) => menuItem.isFood == false))
                          CustomCard(
                            text: menuItemType.name,
                            onPressed: () => {
                              Provider.of<MenuItemTypesProvider>(
                                context,
                                listen: false,
                              ).setSelectedType(
                                  typeId: menuItemType.id,
                                  typeName: menuItemType.name),
                              Provider.of<MenuItemTypesProvider>(
                                context,
                                listen: false,
                              ).getMenuItems(typeId: menuItemType.id),
                              context.go('/order/itemTypes/menuItems'),
                            },
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
