// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controller/navbar_controller.dart';
import '../widget/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  final NavbarController navbarController = Get.find();
  double _lastOffset = 0;
  final MarqueeController marqueeController = MarqueeController();

  final List<String> banners = [
    'assets/images/v_banner.png',
    'assets/images/hodie_two.png',
    'assets/images/v_one_baaner.png',
    'assets/images/v_two_banner.png',
    'assets/images/hodie_three.png',
    'assets/images/v_three.png',
    'assets/images/hodie_four.png',
    'assets/images/v_four.png',
    'assets/images/hodie_one.png',
  ];

  final List<Map<String, String>> categories = [
    {'name': 'Top Wear', 'images': 'assets/images/o_s_cat.png'},
    {'name': 'Bottom Wear', 'images': 'assets/images/cargo_c.png'},
    {'name': 'Footwear', 'images': 'assets/images/jeans_c.png'},
    {'name': 'Accessories', 'images': 'assets/images/shirst_c.png'},
    {'name': 'Sale', 'images': 'assets/images/l_d_four.png'},
    {'name': 'Brands', 'images': 'assets/images/l_d_two.png'},
    {'name': 'New', 'images': 'assets/images/l_d_one.png'},
    {'name': 'Trending', 'images': 'assets/images/l_d_three.png'},
  ];

  final List<Map<String, String>> marqueeCategories = [
    {'name': 'Oversized T-Shirt', 'icon': '👕'},
    {'name': 'Street Shorts', 'icon': '🩳'},
    {'name': 'Chinos', 'icon': '👖'},
    {'name': 'Relaxed Fit', 'icon': '👔'},
    {'name': 'Retro Varsity', 'icon': '🧥'},
    {'name': 'Denim Jacket', 'icon': '🧥'},
    {'name': 'Cargo Pants', 'icon': '👖'},
    {'name': 'Hoodies', 'icon': '👕'},
    {'name': 'Sneakers', 'icon': '👟'},
    {'name': 'Accessories', 'icon': '🕶️'},
  ];

  final List<Map<String, String>> marqueeCategories2 = [
    {'name': 'Graphic Tees', 'icon': '👕'},
    {'name': 'Joggers', 'icon': '🩳'},
    {'name': 'Bomber Jackets', 'icon': '🧥'},
    {'name': 'Track Pants', 'icon': '👖'},
    {'name': 'Sweatshirts', 'icon': '👕'},
    {'name': 'Casual Shoes', 'icon': '👟'},
    {'name': 'Caps & Hats', 'icon': '🧢'},
    {'name': 'Backpacks', 'icon': '🎒'},
    {'name': 'Watches', 'icon': '⌚'},
    {'name': 'Sunglasses', 'icon': '🕶️'},
  ];

  final List<Map<String, String>> latestDrops = [
    {'name': 'Denim Jacket', 'image': 'assets/images/l_d_one.png'},
    {'name': 'Sneakers', 'image': 'assets/images/l_d_two.png'},
    {'name': 'Printed Top', 'image': 'assets/images/l_d_three.png'},
    {'name': 'Maxi Dress', 'image': 'assets/images/l_d_four.png'},
  ];

  final List<Map<String, String>> offers = [
    {'name': 'Denim Jacket', 'image': 'assets/images/offer_one.png'},
    {'name': 'Sneakers', 'image': 'assets/images/offer_two.png'},
    {'name': 'Printed Top', 'image': 'assets/images/offer_three.png'},
    {'name': 'Maxi Dress', 'image': 'assets/images/offer_four.png'},
  ];

  final List<Map<String, dynamic>> edit90List = [
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
      'image': 'assets/images/t_shirt_one.png',
    },
    {
      'name': 'Running Shoes',
      'desc': 'Lightweight and durable',
      'price': 2999,
      'discount': 2499,
      'image': 'assets/images/hodie_two.png',
    },
    {
      'name': 'Track Jacket',
      'desc': 'Sporty and cool',
      'price': 1799,
      'discount': 1399,
      'image': 'assets/images/t_shirt_three.png',
    },
  ];

  int bannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    _tabController.addListener(() {
      setState(() {});
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final currentOffset = _scrollController.offset;
    if (currentOffset > _lastOffset && currentOffset > 0) {
      // Scrolling down
      if (navbarController.isVisible.value) {
        navbarController.hideNavbar();
      }
    } else if (currentOffset < _lastOffset) {
      // Scrolling up
      if (!navbarController.isVisible.value) {
        navbarController.showNavbar();
      }
    }
    _lastOffset = currentOffset;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Color getGradientColor() {
    return _tabController.index == 0
        ? const Color(0xFF6678FF)
        : const Color(0xFFE24A6B);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          Obx(() => SliverAppBar(
                pinned: true,
                expandedHeight: navbarController.isVisible.value ? 120 : 60,
                backgroundColor: theme.scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: navbarController.isVisible.value ? 1.0 : 0.0,
                        curve: Curves.easeInOut,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                getGradientColor().withOpacity(0.5),
                                getGradientColor().withOpacity(0.4),
                                getGradientColor().withOpacity(0.0),
                              ],
                              center: Alignment.topCenter,
                              radius: 0.85,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '&Im',
                            style: TextStyle(
                                color: theme.colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: theme.colorScheme.onSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Shreepal Complex, Surat R...',
                                style: TextStyle(
                                    color: theme.colorScheme.onSecondary,
                                    fontSize: 12),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                                color: theme.colorScheme.onSecondary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              CupertinoIcons.search,
                              color: theme.colorScheme.onSecondary,
                            ),
                            onPressed: () {
                              GoRouter.of(context).push('/search');
                            }),
                        IconButton(
                            icon: Icon(CupertinoIcons.heart,
                                color: theme.colorScheme.onSecondary),
                            onPressed: () {
                              GoRouter.of(context).push('/wishlist');
                            }),
                        IconButton(
                            icon: Icon(
                              CupertinoIcons.person_circle,
                              color: theme.colorScheme.onSecondary,
                            ),
                            onPressed: () {
                              GoRouter.of(context).push('/profile');
                            }),
                      ],
                    ),
                  ],
                ),
                bottom: navbarController.isVisible.value
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(60),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70.0),
                                  child: _buildCustomTabBar(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : null,
              )),
        ],
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildTabContent(context, true),
            _buildTabContent(context, false),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    final theme = Theme.of(context);
    return Row(
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
                      'MAN',
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
                  top: -16,
                  left: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/images/man_images.png',
                      width: 40,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
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
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Text(
                      'WOMAN',
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
    );
  }

  Widget _buildTabContent(BuildContext context, bool isMen) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                isMen && isDark
                    ? 'assets/images/dripstar_banner.png'
                    : isMen && !isDark
                        ? 'assets/images/dripstar_light.png'
                        : !isMen && isDark
                            ? 'assets/images/dripstar_banner_women.png'
                            : 'assets/images/dripstar_light_w.png',
                width: double.infinity,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Banner Section with CarouselSlider and auto scroll
          SizedBox(
            height: 400,
            child: CarouselSlider.builder(
              itemCount: banners.length,
              options: CarouselOptions(
                height: 400,
                viewportFraction: 0.8,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enlargeFactor: 0.30,
                initialPage: 1,
                onPageChanged: (i, reason) => setState(() => bannerIndex = i),
              ),
              itemBuilder: (context, index, realIdx) {
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push("/category/new arrivals");
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(banners[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: PhysicalShape(
              color: theme.scaffoldBackgroundColor,
              elevation: 5,
              shadowColor: isDark
                  ? theme.colorScheme.onSurface.withOpacity(0.3)
                  : theme.dividerColor.withOpacity(0.35),
              clipper: BottomCurveClipper(),
              child: Container(
                height: 20,
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          SizedBox(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (categories.length / 4).ceil(),
                itemBuilder: (context, colIndex) {
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                          '/category/${categories[colIndex * 4]['name']}');
                    },
                    child: Column(
                      children: [
                        for (int row = 0; row < 2; row++)
                          Row(
                            children: [
                              for (int i = 0; i < 4; i++)
                                if ((colIndex * 4 + row * 4 + i) <
                                    categories.length)
                                  Column(
                                    children: [
                                      Container(
                                        width: 85,
                                        height: 85,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(0, 2))
                                          ],
                                        ),
                                        child: Image.asset(
                                          categories[colIndex * 4 + row * 4 + i]
                                              ['images']!,
                                          width: 85,
                                          height: 85,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 85,
                                        height: 35,
                                        child: Text(
                                          categories[colIndex * 4 + row * 4 + i]
                                              ['name']!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                            ],
                          )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              (categories.length / 4).ceil(),
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Latest Drops',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: latestDrops.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final drop = latestDrops[index];
                return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/category/${drop['name']}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(drop['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
              },
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Text(
              'Offers',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: offers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final offer = offers[index];
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/category/${offer['name']}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(offer['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 25),

          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/category/big sale");
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/h_banner.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 340,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: edit90List.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 0),
                        itemBuilder: (context, index) {
                          final product = edit90List[index];
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

          SizedBox(height: 25),

          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/category/big sale");
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/h_two_baaner.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 340,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: edit90List.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 0),
                        itemBuilder: (context, index) {
                          final product = edit90List[index];
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

          // Marquee Categories Section
          const SizedBox(height: 32),
          _buildMarqueeSection(context),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMarqueeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "No Clue? Start Here!" text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'No Clue? Start Here!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        const SizedBox(height: 16),

        // First Marquee - Fast Speed (Left to Right)
        SizedBox(
          height: 40,
          child: AutoMarquee(
            controller: marqueeController,
            items: marqueeCategories.map((cat) => cat['name']!).toList(),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            gap: 0,
            velocity: 60, // Very fast speed
            reverse: false, // Left to right
            onItemTap: (categoryName) {
              GoRouter.of(context).push("/category/$categoryName");
            },
          ),
        ),
        const SizedBox(height: 10),
        // Second Marquee - Medium Speed with Different Categories (Left to Right)
        SizedBox(
          height: 40,
          child: AutoMarquee(
            controller: marqueeController,
            items: marqueeCategories2.map((cat) => cat['name']!).toList(),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            gap: 0,
            velocity: 50, // Medium-fast speed
            reverse: false, // Same direction - left to right
            onItemTap: (categoryName) {
              GoRouter.of(context).push("/category/$categoryName");
            },
          ),
        ),

        const SizedBox(height: 80),

        // Bottom motivational text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURATING CONFIDENCE',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.05,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.start,
              ),
              Text(
                'ONE OUTFIT AT A TIME.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.05,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),
              Text(
                'Always, &Im Team',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.normal,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2, size.height + 20, // control point
      size.width, size.height - 20, // end point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AutoMarquee extends StatefulWidget {
  final List<String> items;
  final TextStyle? textStyle;
  final double gap;
  final double velocity;
  final Function(String)? onItemTap;
  final bool reverse;
  final MarqueeController? controller;

  const AutoMarquee({
    required this.items,
    this.textStyle,
    this.gap = 0,
    this.velocity = 50,
    this.onItemTap,
    this.reverse = false,
    this.controller,
  });

  @override
  State<AutoMarquee> createState() => AutoMarqueeState();
}

class AutoMarqueeState extends State<AutoMarquee> {
  late final ScrollController _ctrl;
  Timer? _timer;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    _ctrl = ScrollController();
    MarqueeController.register(this);
    widget.controller?.addListener(_onPauseChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  void _onPauseChanged() {
    if (widget.controller?.value == true) {
      pause();
    } else {
      resume();
    }
  }

  void pause() {
    _paused = true;
    _timer?.cancel();
  }

  void resume() {
    if (!_paused) return;
    _paused = false;
    _timer?.cancel();
    _loopScroll();
  }

  Future<void> _start() async {
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _loopScroll();
  }

  void _loopScroll() {
    if (!mounted || _paused) return;
    if (!_ctrl.hasClients) {
      _timer = Timer(const Duration(milliseconds: 200), _loopScroll);
      return;
    }
    final max = _ctrl.position.maxScrollExtent;
    if (max <= 10) {
      _timer = Timer(const Duration(seconds: 1), _loopScroll);
      return;
    }
    double currentScrollPosition = _ctrl.position.pixels;
    if (widget.reverse) {
      if (currentScrollPosition <= 0) {
        _ctrl.jumpTo(max);
      } else {
        _ctrl.jumpTo(currentScrollPosition - 1);
      }
    } else {
      if (currentScrollPosition >= max) {
        _ctrl.jumpTo(0);
      } else {
        _ctrl.jumpTo(currentScrollPosition + 1);
      }
    }
    _timer = Timer(const Duration(milliseconds: 1), _loopScroll);
  }

  @override
  void dispose() {
    MarqueeController.unregister(this);
    widget.controller?.removeListener(_onPauseChanged);
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: widget.items.isEmpty
          ? const Center(child: Text('No categories'))
          : GestureDetector(
              onDoubleTap: () => MarqueeController.pauseAll(),
              onTapDown: (_) => MarqueeController.pauseAll(),
              onTapUp: (_) => MarqueeController.resumeAll(),
              onTapCancel: () => MarqueeController.resumeAll(),
              onPanDown: (_) => MarqueeController.pauseAll(),
              onPanEnd: (_) => MarqueeController.resumeAll(),
              child: ListView.builder(
                controller: _ctrl,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.items.length * 10,
                itemBuilder: (context, index) {
                  final item = widget.items[index % widget.items.length];
                  return _buildItem(item);
                },
              ),
            ),
    );
  }

  Widget _buildItem(String text) {
    return InkWell(
      onTap: () async {
        widget.onItemTap?.call(text);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) resume();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: widget.textStyle ??
                  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarqueeController extends ValueNotifier<bool> {
  MarqueeController() : super(false);

  // Registry for all marquees
  static final List<AutoMarqueeState> _marquees = [];

  static void register(AutoMarqueeState state) {
    _marquees.add(state);
  }

  static void unregister(AutoMarqueeState state) {
    _marquees.remove(state);
  }

  static void pauseAll() {
    for (final marquee in _marquees) {
      marquee.pause();
    }
  }

  static void resumeAll() {
    for (final marquee in _marquees) {
      marquee.resume();
    }
  }
}
