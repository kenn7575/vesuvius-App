import 'package:app/features/displayMenuItems/presentation/pages/menu_item_page.dart';
import 'package:app/features/displayMenuItems/presentation/pages/menu_item_type_page.dart';
import 'package:app/features/order/presentation/pages/orders_page.dart';
import 'package:app/features/select_table_for_order/presentation/pages/select_tables_page.dart';
import 'package:app/features/select_table_for_order/presentation/pages/select_reservation_page.dart';
import 'package:app/features/order/presentation/widgets/cart_sheet.dart';
import 'package:app/features/skeleton/widgets/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute(
      navigatorContainerBuilder: (context, navigationShell, children) {
        return Scaffold(
          body: children[navigationShell.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/');
                  break;
                case 1:
                  context.go('/kitchen');
                  break;
                case 2:
                  context.push(
                      '/order'); // Use push instead of go to navigate outside bottom nav
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: 'Reservations'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.kitchen), label: 'Kitchen'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Orders'),
            ],
          ),
        );
      },
      builder: (context, state, child) {
        return Scaffold(
          body: child,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/', // Reservation page
              builder: (BuildContext context, GoRouterState state) {
                return const Center(child: Text("Reservations"));
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/kitchen', // Kitchen page
              builder: (BuildContext context, GoRouterState state) {
                return const Center(child: Text("kitchen"));
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/order', // view orders and and link to new order page
      builder: (BuildContext context, GoRouterState state) {
        return const OrderPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/table',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const LocationTabBarPage(
              currentIndex: 0,
              child: SelectTablesPage(), // Your existing SelectTablePage
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: '/reservation',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const LocationTabBarPage(
              currentIndex: 1,
              child: SelectReservationPage(), // Your existing ReservationPage
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: "/overview",
          builder: (BuildContext context, GoRouterState state) {
            return const Text("order/overview"); // waiter order overview page
          },
        ),
        GoRoute(
          path: "/confirmation",
          builder: (BuildContext context, GoRouterState state) {
            return const Text(
                "order/confirmation"); // waiter order confirmation page
          },
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return Scaffold(
              body: Stack(
                children: [
                  child,
                  const CartSheet(),
                ],
              ),
            );
          },
          routes: [
            GoRoute(
              path: "/itemTypes", // waiter table selection page
              builder: (BuildContext context, GoRouterState state) {
                return const MenuItemTypesPage(); // waiter item category selection page
              },
              routes: <RouteBase>[
                GoRoute(
                  path: "/menuItems",
                  builder: (BuildContext context, GoRouterState state) {
                    return const MenuItemPage(); // waiter menu item selection page
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/kitchen", // kitchen page for displaying orders
      builder: (BuildContext context, GoRouterState state) {
        return const Text("kitchen");
      },
    ),
  ],
);
