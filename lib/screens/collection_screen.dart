// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  final GlobalKey _scrollKey = GlobalKey();
  List<GlobalKey> _sectionKeys = [];

  final List<String> categories = [
    'Brands',
    'Top Wear',
    'Bottom Wear',
    'Footwear',
    'Accessories',
    'Sale'
  ];

  final Map<String, List<Map<String, String>>> brands = {
    'Brands': [
      {'name': 'Nike', 'image': 'https://logo.clearbit.com/nike.com'},
      {'name': 'Adidas', 'image': 'https://logo.clearbit.com/adidas.com'},
      {'name': 'Puma', 'image': 'https://logo.clearbit.com/puma.com'},
      {'name': 'Reebok', 'image': 'https://logo.clearbit.com/reebok.com'},
    ],
    'Top Wear': [
      {'name': 'Levi’s', 'image': 'https://logo.clearbit.com/levi.com'},
      {'name': 'Zara', 'image': 'https://logo.clearbit.com/zara.com'},
    ],
    'Bottom Wear': [
      {'name': 'Wrangler', 'image': 'https://logo.clearbit.com/wrangler.com'},
      {'name': 'Lee', 'image': 'https://logo.clearbit.com/lee.com'},
    ],
    'Footwear': [
      {'name': 'Bata', 'image': 'https://logo.clearbit.com/bata.com'},
      {
        'name': 'Woodland',
        'image': 'https://logo.clearbit.com/woodlandworldwide.com'
      },
    ],
    'Accessories': [
      {'name': 'Fossil', 'image': 'https://logo.clearbit.com/fossil.com'},
      {'name': 'RayBan', 'image': 'https://logo.clearbit.com/ray-ban.com'},
    ],
    'Sale': [
      {
        'name': 'Sale Brand 1',
        'image': 'https://logo.clearbit.com/example.com'
      },
      {
        'name': 'Sale Brand 2',
        'image': 'https://logo.clearbit.com/example.com'
      },
    ],
  };

  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _sectionKeys = List.generate(categories.length, (_) => GlobalKey());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollKey.currentContext == null) return;
    final scrollRender =
        _scrollKey.currentContext!.findRenderObject() as RenderBox;
    final viewportTop = scrollRender.localToGlobal(Offset.zero).dy;
    double minDelta = double.infinity;
    int newSelected = -1;
    for (int i = 0; i < _sectionKeys.length; i++) {
      final keyContext = _sectionKeys[i].currentContext;
      if (keyContext == null) continue;
      final sectionRender = keyContext.findRenderObject() as RenderBox;
      final sectionTop = sectionRender.localToGlobal(Offset.zero).dy;
      final delta = sectionTop - viewportTop;
      if (delta >= 0 && delta < minDelta) {
        minDelta = delta;
        newSelected = i;
      }
    }
    if (newSelected == -1 && _sectionKeys.isNotEmpty) {
      newSelected = _sectionKeys.length - 1;
    }
    if (newSelected != selectedCategory) {
      setState(() {
        selectedCategory = newSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text('Collection',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: theme.colorScheme.onSecondary)),
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.search,
                  color: theme.colorScheme.onSecondary),
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
              icon: Icon(CupertinoIcons.person_circle,
                  color: theme.colorScheme.onSecondary),
              onPressed: () {
                GoRouter.of(context).push('/profile');
              }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tabController.index = 0;
                    });
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _tabController.index == 0
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: _tabController.index == 0
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.15)
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'MAN',
                        style: TextStyle(
                          color: _tabController.index == 0
                              ? theme.colorScheme.onSecondary
                              : theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tabController.index = 1;
                    });
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _tabController.index == 1
                            ? Colors.red
                            : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: _tabController.index == 1
                          ? Colors.red.withOpacity(0.15)
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'WOMAN',
                        style: TextStyle(
                          color: _tabController.index == 1
                              ? theme.colorScheme.onSecondary
                              : theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              children: [
                _buildCategoryView(context),
                _buildCategoryView(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryView(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.onTertiary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;
                // Get first brand image for category, fallback to null
                final imageUrl = brands[categories[index]]?.isNotEmpty == true
                    ? brands[categories[index]]![0]['image']
                    : null;
                return InkWell(
                  onTap: () {
                    setState(() => selectedCategory = index);
                    Scrollable.ensureVisible(
                      _sectionKeys[index].currentContext!,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Container(
                              width: 5,
                              height: 70,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.colorScheme.onSecondary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (imageUrl != null)
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[200],
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  categories[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.onTertiary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: SingleChildScrollView(
                    key: _scrollKey,
                    controller: _scrollController,
                    child: Column(
                      children: List.generate(categories.length, (index) {
                        final cat = categories[index];
                        final brandList = brands[cat] ?? [];
                        return Container(
                          key: _sectionKeys[index],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  cat,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 3 / 5,
                                ),
                                itemCount: brandList.length,
                                itemBuilder: (context, idx) {
                                  final brand = brandList[idx];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            color: Colors.grey[200],
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(brand['image']!),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 8),
                                        child: Text(
                                          brand['name']!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                theme.colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: theme.scaffoldBackgroundColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.arrow_forward,
                                              color:
                                                  theme.colorScheme.onSecondary,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'See All',
                                              style: TextStyle(
                                                color: theme
                                                    .colorScheme.onSecondary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.shopping_cart_checkout,
                                              color: Colors.transparent,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Checkout',
                                              style: TextStyle(
                                                color: Colors.transparent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
