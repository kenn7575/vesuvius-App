import 'package:app/features/displayMenuItems/presentation/providers/menu_item_type_provider.dart';
import 'package:app/features/displayMenuItems/presentation/widgets/phone_menu_item_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuItemPage extends StatelessWidget {
  const MenuItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? menuItemTymeName =
        Provider.of<MenuItemTypesProvider>(context).selectedTypeName;
    var screenSize = MediaQuery.of(context).size;
    int phoneWidth = 1080;

    // Widget layout = screenSize > phoneWidth ? :
    return Scaffold(
      body: const Center(child: PhoneMenuItemGrid()),
      appBar: AppBar(
        centerTitle: true,
        title: Text(menuItemTymeName ?? 'Menu Items'),
        leading: BackButton(
          onPressed: () {
            print('Current location: ${GoRouter.of(context).state?.path}');
            print('Attempting to navigate to: /order/itemTypes');
            GoRouter.of(context).go('/order/itemTypes');
          },
        ),
      ),
    );
  }
}
