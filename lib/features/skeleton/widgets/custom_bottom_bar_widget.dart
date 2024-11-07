import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/selected_page_provider.dart';

class CustomBottomBarWidget extends StatelessWidget {
  const CustomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationBar(
        onDestinationSelected: (int index) {
          Provider.of<SelectedPageProvider>(context, listen: false)
              .changePage(index);
        },
        indicatorColor: Colors.amber,
        selectedIndex: Provider.of<SelectedPageProvider>(context, listen: false)
            .selectedPage,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.menu_book),
            icon: Icon(Icons.home_outlined),
            label: 'Bestil',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Køkken',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_calendar),
            label: 'Reservationer',
          ),
        ],
      ),
    );
  }
}
