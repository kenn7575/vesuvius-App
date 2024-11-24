import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationTabBarPage extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const LocationTabBarPage(
      {super.key, required this.child, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: currentIndex,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Location"),
            bottom: TabBar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go('/orders/table');
                    break;
                  case 1:
                    context.go('/orders/reservation');
                    break;
                }
              },
              labelStyle: const TextStyle(
                color: Colors.white,
              ), //For Selected tab
              unselectedLabelStyle:
                  const TextStyle(fontSize: 10.0, fontFamily: 'Family Name'),
              tabs: const [
                Tab(
                  icon: Icon(Icons.table_bar),
                  text: "Borde",
                ),
                Tab(icon: Icon(Icons.people), text: "Reservationer"),
              ],
            ),
          ),
          body: child,
        ),
      ),
    );
  }
}
