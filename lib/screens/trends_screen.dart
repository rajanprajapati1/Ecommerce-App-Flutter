// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controller/navbar_controller.dart';
import '../widget/product_widget.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({super.key});

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NavbarController navbarController = Get.find();
  late ScrollController _scrollController;

  final List<Map<String, dynamic>> menTrends = [
    {
      'title': 'Street Style',
      'message': 'Urban looks for every day.',
      'banner': 'assets/images/h_banner.png',
      'products': [
        {
          'name': 'Oversized Hoodie',
          'desc': 'Comfortable and stylish',
          'price': 1299,
          'discount': 999,
          'image': 'assets/images/hodie_one.png',
        },
        {
          'name': 'Cargo Pants',
          'desc': 'Trendy utility wear',
          'price': 1599,
          'discount': 1199,
          'image': 'assets/images/cargo_c.png',
        },
        {
          'name': 'Graphic Tee',
          'desc': 'Bold and expressive',
          'price': 799,
          'discount': 599,
          'image': 'assets/images/t_shirt_one.png',
        },
      ],
    },
    {
      'title': 'Athleisure',
      'message': 'Sporty comfort meets style.',
      'banner': 'assets/images/h_one_baaner.png',
      'products': [
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
          'image': 'assets/images/l_d_four.png',
        },
        {
          'name': 'Jogger Pants',
          'desc': 'Comfort fit',
          'price': 1299,
          'discount': 999,
          'image': 'assets/images/l_d_one.png',
        },
      ],
    },
    {
      'title': 'Classic Denim',
      'message': 'Timeless blue for every mood.',
      'banner': 'assets/images/h_two_baaner.png',
      'products': [
        {
          'name': 'Denim Jacket',
          'desc': 'Timeless style',
          'price': 1999,
          'discount': 1499,
          'image': 'assets/images/offer_four.png',
        },
        {
          'name': 'Slim Jeans',
          'desc': 'Perfect fit',
          'price': 1499,
          'discount': 999,
          'image': 'assets/images/t_shirt_one.png',
        },
        {
          'name': 'Denim Shirt',
          'desc': 'Casual cool',
          'price': 1299,
          'discount': 899,
          'image': 'assets/images/jeans_c.png',
        },
      ],
    },
    {
      'title': 'Smart Casual',
      'message': 'Effortlessly stylish for any occasion.',
      'banner': 'assets/images/h_two_baaner.png',
      'products': [
        {
          'name': 'Chinos',
          'desc': 'Versatile and comfortable',
          'price': 1499,
          'discount': 1199,
          'image': 'assets/images/t_shirt_two.png',
        },
        {
          'name': 'Casual Shirt',
          'desc': 'Perfect for layering',
          'price': 999,
          'discount': 799,
          'image': 'assets/images/t_shirt_two.png',
        },
        {
          'name': 'Loafers',
          'desc': 'Classic and comfortable',
          'price': 1999,
          'discount': 1599,
          'image': 'assets/images/offer_three.png',
        },
      ],
    },
    {
      'title': 'Smart Casual',
      'message': 'Effortlessly stylish for any occasion.',
      'banner': 'assets/images/h_banner.png',
      'products': [
        {
          'name': 'Chinos',
          'desc': 'Versatile and comfortable',
          'price': 1499,
          'discount': 1199,
          'image': 'assets/images/v_banner.png',
        },
        {
          'name': 'Casual Shirt',
          'desc': 'Perfect for layering',
          'price': 999,
          'discount': 799,
          'image': 'assets/images/o_s_cat.png',
        },
        {
          'name': 'Loafers',
          'desc': 'Classic and comfortable',
          'price': 1999,
          'discount': 1599,
          'image': 'assets/images/offer_four.png',
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> womenTrends = [
    {
      'title': 'Boho Chic',
      'message': 'Free-spirited and colorful.',
      'banner': 'assets/images/h_one_baaner.png',
      'products': [
        {
          'name': 'Floral Dress',
          'desc': 'Light and breezy',
          'price': 1899,
          'discount': 1399,
          'image': 'assets/images/shirst_c.png',
        },
        {
          'name': 'Fringe Bag',
          'desc': 'Boho accessory',
          'price': 999,
          'discount': 799,
          'image': 'assets/images/t_shirt_two.png',
        },
        {
          'name': 'Ankle Boots',
          'desc': 'Comfortable and stylish',
          'price': 2499,
          'discount': 1999,
          'image': 'assets/images/offer_four.png',
        },
      ],
    },
    {
      'title': 'Power Dressing',
      'message': 'Sharp looks for bold moves.',
      'banner': 'assets/images/h_banner.png',
      'products': [
        {
          'name': 'Blazer',
          'desc': 'Sharp and formal',
          'price': 2499,
          'discount': 1999,
          'image': 'assets/images/v_one_baaner.png',
        },
        {
          'name': 'Pencil Skirt',
          'desc': 'Elegant fit',
          'price': 1299,
          'discount': 999,
          'image': 'assets/images/v_three.png',
        },
        {
          'name': 'Blouse',
          'desc': 'Elegant and stylish',
          'price': 1499,
          'discount': 1199,
          'image': 'assets/images/hodie_three.png',
        }
      ],
    },
    {
      'title': 'Summer Prints',
      'message': 'Brighten up your wardrobe.',
      'banner': 'assets/images/h_one_baaner.png',
      'products': [
        {
          'name': 'Printed Top',
          'desc': 'Vibrant colors',
          'price': 799,
          'discount': 599,
          'image': 'assets/images/v_two_banner.png',
        },
        {
          'name': 'Maxi Dress',
          'desc': 'Flowy and fun',
          'price': 1599,
          'discount': 1199,
          'image': 'assets/images/l_d_two.png',
        },
        {
          'name': 'Wedges',
          'desc': 'Comfortable heels',
          'price': 2199,
          'discount': 1799,
          'image': 'assets/images/offer_two.png',
        },
      ],
    },
    {
      'title': 'Smart Casual',
      'message': 'Effortlessly stylish for any occasion.',
      'banner': 'assets/images/h_banner.png',
      'products': [
        {
          'name': 'Chinos',
          'desc': 'Versatile and comfortable',
          'price': 1499,
          'discount': 1199,
          'image': 'assets/images/v_one_baaner.png',
        },
        {
          'name': 'Casual Shirt',
          'desc': 'Perfect for layering',
          'price': 999,
          'discount': 799,
          'image': 'assets/images/offer_three.png',
        },
        {
          'name': 'Loafers',
          'desc': 'Classic and comfortable',
          'price': 1999,
          'discount': 1599,
          'image': 'assets/images/offer_four.png',
        },
      ],
    },
    {
      'title': 'Smart Casual',
      'message': 'Effortlessly stylish for any occasion.',
      'banner': 'assets/images/h_two_baaner.png',
      'products': [
        {
          'name': 'Chinos',
          'desc': 'Versatile and comfortable',
          'price': 1499,
          'discount': 1199,
          'image': 'assets/images/v_three.png',
        },
        {
          'name': 'Casual Shirt',
          'desc': 'Perfect for layering',
          'price': 999,
          'discount': 799,
          'image': 'assets/images/shirst_c.png',
        },
        {
          'name': 'Loafers',
          'desc': 'Classic and comfortable',
          'price': 1999,
          'discount': 1599,
          'image': 'assets/images/offer_three.png',
        },
        {
          'name': 'Ankle Boots',
          'desc': 'Comfortable and stylish',
          'price': 2499,
          'discount': 1999,
          'image': 'assets/images/offer_four.png',
        },
        {
          'name': 'Sneakers',
          'desc': 'Casual and trendy',
          'price': 2999,
          'discount': 2499,
          'image': 'assets/images/cargo_c.png',
        }
      ],
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll); // Add this
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      navbarController.isVisible.value = false;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      navbarController.isVisible.value = true;
    }
  }

  Color getGradientColor() {
    return _tabController.index == 0
        ? const Color(0xFF6678FF)
        : const Color(0xFFE24A6B);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose(); // Add this
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
          _buildTrendsContent(context, menTrends, 'Trends for', 'Man',
              'Discover the latest urban, sporty, and classic looks.',
              scrollController: _scrollController),
          _buildTrendsContent(context, womenTrends, 'Trends for', 'Woman',
              'Express yourself with boho, power, and summer styles.',
              scrollController: _scrollController),
        ],
      ),
    );
  }

  Widget _buildTrendsContent(
      BuildContext context,
      List<Map<String, dynamic>> trends,
      String title,
      String subTitle,
      String message,
      {required ScrollController scrollController}) {
    final theme = Theme.of(context);
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Text(subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        ...trends.map((trend) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      // Handle banner tap if needed
                      GoRouter.of(context).push('/category/${trend['title']}');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        trend['banner'],
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 330,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: (trend['products'] as List).length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 5),
                              itemBuilder: (context, idx) {
                                final product = trend['products'][idx];
                                return SizedBox(
                                  width: 180,
                                  child: ProductCard(product: product),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            )),
      ],
    );
  }
}
