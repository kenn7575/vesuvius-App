import 'package:flutter/material.dart';
import 'package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart';
import 'package:app/features/displayMenuItems/presentation/providers/menu_item_type_provider.dart';

import 'package:provider/provider.dart';

class MenuItemTypesPage extends StatelessWidget {
  const MenuItemTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? errorMessage =
        Provider.of<MenuItemTypesProvider>(context).failure?.errorMessage;
    List<MenuItemTypeEntity>? menuItemTypes =
        Provider.of<MenuItemTypesProvider>(context).menuItemTypes;
    return Scaffold(
        body: Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(errorMessage ?? ''),
            Text(menuItemTypes?[0].name ?? ''),
            MaterialButton(
              onPressed: () {
                Provider.of<MenuItemTypesProvider>(context, listen: false)
                    .getMenuItemTypes();
              },
              child: const Text('Get Menu Item Types'),
            ),
          ],
        ),
      ),
    ));
  }
}
