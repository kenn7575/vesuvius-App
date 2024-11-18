import 'package:app/features/displayMenuItems/presentation/pages/menu_item_type_page.dart';
import 'package:app/features/new_order/presentation/pages/new_order_page.dart';
import 'package:app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import '../pokemon/presentation/pages/pokemon_page.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_bottom_bar_widget.dart';
import 'providers/selected_page_provider.dart';

List<Widget> pages = const [NewOrderPage(), PokemonPage(), MenuItemTypesPage()];

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Café Vesuviwss'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).signout();
            },
          ),
        ],
      ),
      body: pages[selectedPage],
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
