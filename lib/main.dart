import 'package:app/data_theme.dart';
import 'package:app/features/displayMenuItems/presentation/providers/menu_item_type_provider.dart';
import 'package:app/features/select_table_for_order/presentation/providers/reservation_provider.dart';
import 'package:app/features/select_table_for_order/presentation/providers/table_provider.dart';
import 'package:app/features/skeleton/route_config.dart';
import 'package:app/features/user/presentation/pages/login_page.dart';
import 'package:app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/pokemon/presentation/providers/pokemon_provider.dart';
import 'features/pokemon/presentation/providers/selected_pokemon_item_provider.dart';
import 'features/skeleton/providers/selected_page_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SelectedPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PokemonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedPokemonItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuItemTypesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReservationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableProvider(),
        ),
      ],
      child: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // login logic
    if (Provider.of<UserProvider>(context, listen: true).user == null) {
      return const LoginPage();
    } else {
      return const MainApp();
    }
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: CustomTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Café Vesuvius',
      routerConfig: routerConfig,
    );
  }
}
