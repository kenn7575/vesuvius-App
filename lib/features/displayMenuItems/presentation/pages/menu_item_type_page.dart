import 'package:app/features/displayMenuItems/presentation/widgets/phone_menu_item_type_grid.dart';
import 'package:flutter/material.dart';
import 'package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart';
import 'package:app/features/displayMenuItems/presentation/providers/menu_item_type_provider.dart';

import 'package:provider/provider.dart';

class MenuItemTypesPage extends StatefulWidget {
  const MenuItemTypesPage({super.key});

  @override
  State<MenuItemTypesPage> createState() => _MenuItemTypesPageState();
}

class _MenuItemTypesPageState extends State<MenuItemTypesPage> {
  @override
  void initState() {
    Provider.of<MenuItemTypesProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    int phoneWidth = 1080;

    // Widget layout = screenSize > phoneWidth ? :
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Kategorier'),
        leading: MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("back"),
        ),
      ),
      body: const Center(child: PhoneMenuItemTypeGrid()),
    );
  }
}
