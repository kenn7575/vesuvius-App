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
              // Use the navigationShell to handle tab switching
              navigationShell.goBranch(
                index,
                // Don't animate if we're already on the target branch
                initialLocation: navigationShell.currentIndex == index,
              );
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
        return Scaffold(body: child);
      },
      branches: [
        // First branch - Reservations
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const Center(child: Text("Reservations"));
              },
            ),
          ],
        ),
        // Second branch - Kitchen
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/kitchen',
              builder: (BuildContext context, GoRouterState state) {
                return const Center(child: Text("Kitchen"));
              },
            ),
          ],
        ),
        // Third branch - Orders
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (BuildContext context, GoRouterState state) {
                return const OrderPage();
              },
              routes: [
                GoRoute(
                  path: 'table',
                  pageBuilder: (context, state) => CustomTransitionPage(
                    child: const LocationTabBarPage(
                      currentIndex: 0,
                      child: SelectTablesPage(),
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
                  path: 'reservation',
                  pageBuilder: (context, state) => CustomTransitionPage(
                    child: const LocationTabBarPage(
                      currentIndex: 1,
                      child: SelectReservationPage(),
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
                      path: 'itemTypes',
                      builder: (BuildContext context, GoRouterState state) {
                        return PopScope(
                          canPop: false,
                          onPopInvokedWithResult: (didPop, result) {
                            if (didPop) return;

                            final router = GoRouter.of(context);
                            if (router.canPop()) {
                              router.pop();
                            }
                          },
                          child: const MenuItemTypesPage(),
                        );
                      },
                      routes: <RouteBase>[
                        GoRoute(
                          path: 'menuItems',
                          builder: (BuildContext context, GoRouterState state) {
                            return const MenuItemPage();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
