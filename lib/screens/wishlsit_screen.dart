// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../widget/product_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  final List<String> categories = [
    'All',
    'Top Wear',
    'Bottom Wear',
    'Footwear',
    'Accessories',
  ];
  int selectedCategory = 0;

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Oversized Hoodie',
      'desc': 'Comfortable and stylish',
      'price': 999,
      'discount': 1200,
      'image': 'assets/images/hodie_one.png',
    },
    {
      'name': 'Cargo Pants',
      'desc': 'Trendy utility wear',
      'price': 1199,
      'discount': 1500,
      'image': 'assets/images/t_shirt_one.png',
    },
    {
      'name': 'Sneakers',
      'desc': 'White, trendy',
      'price': 1299,
      'discount': 1800,
      'image': 'assets/images/v_one_baaner.png',
    },
    {
      'name': 'Watch',
      'desc': 'Analog, stylish',
      'price': 1499,
      'discount': 2000,
      'image': 'assets/images/l_d_two.png',
    },
    {
      'name': 'Backpack',
      'desc': 'Spacious and durable',
      'price': 1999,
      'discount': 2500,
      'image': 'assets/images/v_two_banner.png',
    },
    {
      'name': 'Smartphone',
      'desc': 'Latest model with advanced features',
      'price': 6999,
      'discount': 799,
      'image': 'assets/images/hodie_three.png',
    }
  ];

  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 28),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        '&Im',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.search,
              size: 26, color: theme.colorScheme.onSecondary),
          onPressed: () {
            GoRouter.of(context).push('/search');
          },
        ),
        IconButton(
          icon: Icon(HugeIcons.strokeRoundedShoppingBag02,
              size: 26, color: theme.colorScheme.onSecondary),
          onPressed: () {
            GoRouter.of(context).push('/cart');
          },
        ),
      ],
    );
  }

  Widget _buildPinnedWishlistText(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool atTop = _scrollOffset < 40;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: atTop ? Alignment.centerLeft : Alignment.center,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: atTop
            ? const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
            : const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        child: Text(
          'WISHLIST',
          style: TextStyle(color: theme.colorScheme.onSecondary, fontSize: 28),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onSurface.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: List.generate(categories.length, (index) {
                final selected = selectedCategory == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedCategory = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 7),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(8),
                        border: selected
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1,
                              )
                            : null,
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontWeight:
                              selected ? FontWeight.normal : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 0) return products;
    return products.where((p) {
      switch (selectedCategory) {
        case 1:
          return p['name'].toString().contains('Hoodie') ||
              p['name'].toString().contains('Shirt');
        case 2:
          return p['name'].toString().contains('Pants');
        case 3:
          return p['name'].toString().contains('Sneakers');
        case 4:
          return p['name'].toString().contains('Watch');
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              _scrollOffset = _scrollController.offset;
            });
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _WishlistHeaderDelegate(
                child: _buildPinnedWishlistText(context),
                minExtent: 44,
                maxExtent: 56,
              ),
            ),
            SliverPersistentHeader(
              delegate: _WishlistHeaderDelegate(
                child: _buildTabBar(context),
                minExtent: 56,
                maxExtent: 64,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.50,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      product: product,
                      isWishlist: true,
                      isCart: false,
                    );
                  },
                  childCount: filteredProducts.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minExtent;
  final double maxExtent;

  _WishlistHeaderDelegate({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_WishlistHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}
