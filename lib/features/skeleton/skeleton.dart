import 'package:app/features/new_order/presentation/pages/new_order_page.dart';
import 'package:flutter/material.dart';
import '../pokemon/presentation/pages/data_page.dart';
import '../pokemon/presentation/pages/pokemon_page.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_bottom_bar_widget.dart';
import 'providers/selected_page_provider.dart';

List<Widget> pages = const [
  NewOrderPage(),
  PokemonPage(),
  DataPage(),
];

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Café Vesuvius'),
      ),
      body: pages[selectedPage],
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
