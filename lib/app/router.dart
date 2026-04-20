import 'package:go_router/go_router.dart';

import '../dashboard.dart';
import '../home/home_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/category/category_screen.dart';
import '../screens/collection_screen.dart';
import '../screens/picks_screen.dart';
import '../screens/product_details_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/trends_screen.dart';
import '../screens/wishlsit_screen.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/wishlist',
      builder: (context, state) => const WishlistScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/category/:name',
      builder: (context, state) {
        final categoryName = state.pathParameters['name']!;
        return CategoryScreen(categoryName: categoryName);
      },
    ),
    GoRoute(
        path: '/search',
        builder: (context, state) {
          return SearchScreen();
        }),
    GoRoute(
      path: '/product',
      builder: (context, state) {
        return ProductDetailScreen();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              builder: (context, state) => const CollectionScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/trends',
              builder: (context, state) => const TrendsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/picks',
              builder: (context, state) => const PicksScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const HomeScreen(),
);
