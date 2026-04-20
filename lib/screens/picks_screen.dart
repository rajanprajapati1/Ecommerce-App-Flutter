// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class PicksScreen extends StatefulWidget {
  const PicksScreen({super.key});

  @override
  State<PicksScreen> createState() => _PicksScreenState();
}

class _PicksScreenState extends State<PicksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CardSwiperController _swiperController;

  final List<Map<String, dynamic>> productsMen = [
    {
      'name': 'Oversized Hoodie',
      'desc': 'Comfortable and stylish',
      'price': 1299,
      'discount': 999,
      'image': 'assets/images/o_s_cat.png',
    },
    {
      'name': 'Cargo Pants',
      'desc': 'Trendy utility wear',
      'price': 1599,
      'discount': 1199,
      'image': 'assets/images/hodie_four.png',
    },
    {
      'name': 'Running Shoes',
      'desc': 'Lightweight and durable',
      'price': 2999,
      'discount': 2499,
      'image': 'assets/images/jeans_c.png',
    },
    {
      'name': 'Track Jacket',
      'desc': 'Sporty and cool',
      'price': 1799,
      'discount': 1399,
      'image': 'assets/images/l_d_three.png',
    },
  ];

  final List<Map<String, dynamic>> productsWomen = [
    {
      'name': 'Denim Jacket',
      'desc': 'Classic and versatile',
      'price': 1499,
      'discount': 1099,
      'image': 'assets/images/l_d_one.png',
    },
    {
      'name': 'Sneakers',
      'desc': 'Comfortable footwear',
      'price': 1999,
      'discount': 1599,
      'image': 'assets/images/hodie_three.png',
    },
    {
      'name': 'Printed Top',
      'desc': 'Stylish and trendy',
      'price': 799,
      'discount': 599,
      'image': 'assets/images/l_d_three.png',
    },
    {
      'name': 'Maxi Dress',
      'desc': 'Elegant and flowy',
      'price': 2299,
      'discount': 1899,
      'image': 'assets/images/hodie_one.png',
    },
  ];

  final List<String> filterTypes = [
    'Category',
    'Size',
    'Color',
    'Price',
    'Length',
    'Design'
  ];

  final Map<String, List<String>> filterOptions = {
    'Category': ['Top Wear', 'Bottom Wear', 'Footwear', 'Accessories'],
    'Size': ['S', 'M', 'L', 'XL'],
    'Color': ['Red', 'Blue', 'Green', 'Black'],
    'Price': ['Under 500', '500-1000', '1000-2000', 'Above 2000'],
    'Length': ['Short', 'Medium', 'Long'],
    'Design': ['Printed', 'Solid', 'Striped', 'Checked'],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _swiperController = CardSwiperController();
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _swiperController.dispose();
    super.dispose();
  }

  Color getGradientColor() {
    return _tabController.index == 0
        ? const Color(0xFF6678FF) // Blue for Men
        : const Color(0xFFE24A6B); // Pink/Red for Women
  }

  void _showFilterBottomSheet({String? category}) {
    String selected = category ?? filterTypes[0];
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Clear all filters logic here
                      },
                      child: Text('Clear all',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView(
                          children: filterTypes
                              .map(
                                (type) => ListTile(
                                  title: Text(type),
                                  selected: selected == type,
                                  onTap: () {
                                    setModalState(() => selected = type);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView(
                          children: filterOptions[selected]!
                              .map(
                                (option) => CheckboxListTile(
                                  title: Text(option),
                                  value:
                                      false, // Replace with actual selection logic
                                  onChanged: (bool? value) {
                                    // Handle selection
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Apply filters logic here
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: _buildCustomTabBar(),
        titleSpacing: 16,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search,
                color: theme.colorScheme.onSecondary),
            onPressed: () {
              GoRouter.of(context).push('/search');
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.heart,
                color: theme.colorScheme.onSecondary),
            onPressed: () {
              GoRouter.of(context).push('/wishlist');
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.person_circle,
                color: theme.colorScheme.onSecondary),
            onPressed: () {
              GoRouter.of(context).push('/profile');
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildTabContent(true),
          _buildTabContent(false),
        ],
      ),
    );
  }

  Widget _buildCustomTabBar() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 60.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: _tabController.index == 0
                          ? Border.all(color: getGradientColor(), width: 1)
                          : Border.all(
                              color: theme.disabledColor.withOpacity(0.1),
                              width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: theme.scaffoldBackgroundColor,
                      boxShadow: _tabController.index == 0
                          ? [
                              BoxShadow(
                                color: getGradientColor().withOpacity(0.6),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        'M',
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/man_images.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(1),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: _tabController.index == 1
                          ? Border.all(color: getGradientColor(), width: 1)
                          : Border.all(
                              color: theme.disabledColor.withOpacity(0.1),
                              width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: theme.scaffoldBackgroundColor,
                      boxShadow: _tabController.index == 1
                          ? [
                              BoxShadow(
                                color: getGradientColor().withOpacity(0.6),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Text(
                        'W',
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -11,
                    right: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/women_image.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(bool isMen) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final products = isMen ? productsMen : productsWomen;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            isDark ? theme.scaffoldBackgroundColor : Color(0xFFDEDEDE),
            isDark ? theme.scaffoldBackgroundColor : Color(0xFFDEDEDE),
            isDark ? theme.scaffoldBackgroundColor : Color(0xFFCBCBCB),
            theme.scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: CardSwiper(
              controller: _swiperController,
              cardsCount: products.length,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) =>
                      _ProductCard(product: products[index]),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              scale: 0.9,
              maxAngle: 30,
              threshold: 50,
              isLoop: true,
              numberOfCardsDisplayed: 2,
              allowedSwipeDirection: AllowedSwipeDirection.only(
                left: true,
                right: true,
                up: false,
                down: false,
              ),
              onSwipe: (previousIndex, currentIndex, direction) {
                if (direction == CardSwiperDirection.left) {
                  // Handle dislike
                } else if (direction == CardSwiperDirection.right) {
                  // Handle like (wishlist)
                }
                return true;
              },
              onUndo: (previousIndex, currentIndex, direction) {
                // Handle undo
                return true;
              },
              onEnd: () {
                // Handle when cards run out
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  Icons.replay,
                  25,
                  onTap: () => _swiperController.undo(),
                ),
                _buildActionButton(
                  CupertinoIcons.clear,
                  30,
                  onTap: () =>
                      _swiperController.swipe(CardSwiperDirection.left),
                ),
                _buildActionButton(
                  CupertinoIcons.heart,
                  30,
                  onTap: () =>
                      _swiperController.swipe(CardSwiperDirection.right),
                ),
                _buildActionButton(
                  HugeIcons.strokeRoundedShoppingBag02,
                  25,
                  onTap: () =>
                      _swiperController.swipe(CardSwiperDirection.right),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: _showFilterBottomSheet,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(CupertinoIcons.slider_horizontal_3,
                              color: theme.colorScheme.onSecondary, size: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 25,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                  ),
                  const SizedBox(width: 0),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      children: [
                        ...filterTypes.map(
                          (type) => GestureDetector(
                            onTap: () => _showFilterBottomSheet(category: type),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: theme.colorScheme.tertiary,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    type,
                                    style: TextStyle(
                                        color: theme.colorScheme.onSecondary),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.keyboard_arrow_down,
                                      color: theme.colorScheme.onSecondary,
                                      size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    double sizeRadius, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: sizeRadius,
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        child: Icon(icon,
            color: Theme.of(context).colorScheme.onSecondary, size: 25),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 2,
      color: Theme.of(context).colorScheme.onTertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 360,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('₹${product['discount']}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSecondary)),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text('₹${product['price']}',
                              style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  color: theme.colorScheme.onSecondary
                                      .withOpacity(0.7))),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('20% off',
                              style: TextStyle(
                                  color: theme.colorScheme.onSecondary,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(product['name'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSecondary)),
                    const SizedBox(height: 4),
                    Text(product['desc'],
                        style: TextStyle(
                            fontSize: 14,
                            color: theme.colorScheme.onSecondary
                                .withOpacity(0.7))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
