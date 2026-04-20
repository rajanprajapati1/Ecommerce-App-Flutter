// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../widget/product_widget.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  // Filter options
  final List<String> filterOptions = [
    'Subcategory',
    'Occasion',
    'Size',
    'Color',
    'Price',
    'Trend',
    'Pattern',
    'Fabric',
    'Sleeve Length'
  ];

  int selectedFilter = 0;

  // Gender selection
  String selectedGender = 'Men';
  final List<String> genderOptions = ['All', 'Men', 'Women', 'Unisex'];

  // Sort options
  String selectedSort = 'Recommended';
  final List<String> sortOptions = [
    'Recommended',
    'What\'s New',
    'Price: High to Low',
    'Price: Low to High',
    'Popularity',
    'Discount',
    'Customer Rating'
  ];

  // Filter states
  Map<String, dynamic> filterStates = {
    'brands': <String>[],
    'subcategory': '',
    'occasion': '',
    'size': '',
    'color': '',
    'priceRange': RangeValues(0, 10000),
    'trend': '',
    'pattern': '',
    'fabric': '',
    'sleeveLength': '',
  };

  // Brand list
  final List<String> brands = [
    'Pronk',
    'Hors',
    'Veirdo',
    'Bonkers Corner',
    'The Souled Store',
    'What The Flex',
    'A47'
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Oversized Hoodie',
      'desc': 'Comfortable and stylish',
      'price': 999,
      'discount': 1200,
      'image': 'assets/images/hodie_three.png',
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
      'image': 'assets/images/l_d_four.png',
    },
    {
      'name': 'Watch',
      'desc': 'Analog, stylish',
      'price': 1499,
      'discount': 2000,
      'image': 'assets/images/cargo_c.png',
    },
    {
      'name': 'Backpack',
      'desc': 'Spacious and durable',
      'price': 1999,
      'discount': 2500,
      'image': 'assets/images/jeans_c.png',
    },
    {
      'name': 'Smartphone',
      'desc': 'Latest model with advanced features',
      'price': 6999,
      'discount': 799,
      'image': 'assets/images/t_shirt_three.png',
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
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Left: Back button
                  SizedBox.square(
                    dimension: 48,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: 28, color: theme.colorScheme.onSecondary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  // Center: Title
                  Center(
                    child: Text(
                      '&Im',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  // Right: Actions
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(CupertinoIcons.search,
                              size: 26, color: theme.colorScheme.onSecondary),
                          onPressed: () {
                            GoRouter.of(context).push('/search');
                          },
                        ),
                      ),
                      SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(CupertinoIcons.heart,
                              size: 26, color: theme.colorScheme.onSecondary),
                          onPressed: () {
                            GoRouter.of(context).push('/favorites');
                          },
                        ),
                      ),
                      SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(HugeIcons.strokeRoundedShoppingBag02,
                              size: 26, color: theme.colorScheme.onSecondary),
                          onPressed: () {
                            GoRouter.of(context).push('/cart');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinnedCategoryText(BuildContext context) {
    final theme = Theme.of(context);
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
          widget.categoryName.toUpperCase(),
          style: TextStyle(
              letterSpacing: -1.5, color: theme.colorScheme.onSecondary),
        ),
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: List.generate(filterOptions.length, (index) {
                final selected = selectedFilter == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedFilter = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(8),
                          border: selected
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1,
                                )
                              : null),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            filterOptions[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: selected
                                  ? theme.colorScheme.onSecondary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: selected
                                ? theme.colorScheme.onSecondary
                                : theme.colorScheme.onSurface,
                          )
                        ],
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

  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _showGenderBottomSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 20,
                      color: selectedGender == 'Men'
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Gender',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: selectedGender == 'Men'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (selectedGender == 'Men')
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: _showSortBottomSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.swap_vert,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Sort',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: _showFilterBottomSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.tune,
                      size: 20,
                      color: _hasActiveFilters()
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _hasActiveFilters()
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (_hasActiveFilters())
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasActiveFilters() {
    return filterStates['brands'].isNotEmpty ||
        filterStates['subcategory'].isNotEmpty ||
        filterStates['occasion'].isNotEmpty ||
        filterStates['size'].isNotEmpty ||
        filterStates['color'].isNotEmpty ||
        filterStates['trend'].isNotEmpty ||
        filterStates['pattern'].isNotEmpty ||
        filterStates['fabric'].isNotEmpty ||
        filterStates['sleeveLength'].isNotEmpty;
  }

  void _showGenderBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gender',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...genderOptions.map(
              (gender) => RadioListTile<String>(
                title: Text(gender),
                value: gender,
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                  Navigator.pop(context);
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sort',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...sortOptions.map(
              (sort) => RadioListTile<String>(
                title: Text(sort),
                value: sort,
                groupValue: selectedSort,
                onChanged: (value) {
                  setState(() {
                    selectedSort = value!;
                  });
                  Navigator.pop(context);
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: _clearAllFilters,
                          child: Text(
                            'Clear all',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left sidebar with filter categories
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(
                          right: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.1),
                          ),
                        ),
                      ),
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filterOptions.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedFilter == index;
                          return GestureDetector(
                            onTap: () => setState(() => selectedFilter = index),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1)
                                    : null,
                                border: Border(
                                  left: BorderSide(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Text(
                                filterOptions[index],
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Right content area
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: _buildFilterContent(),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom buttons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.1),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.3),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Apply filters logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
        ),
      ),
    );
  }

  Widget _buildFilterContent() {
    switch (selectedFilter) {
      case 0: // Brand
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: filterStates['brands'].length == brands.length,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        filterStates['brands'] = List<String>.from(brands);
                      } else {
                        filterStates['brands'].clear();
                      }
                    });
                  },
                ),
                Text('Select All (${brands.length})'),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  final isSelected = filterStates['brands'].contains(brand);
                  return CheckboxListTile(
                    title: Text(brand),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          filterStates['brands'].add(brand);
                        } else {
                          filterStates['brands'].remove(brand);
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),
            ),
          ],
        );
      default:
        return Center(
          child: Text(
            'Filter options for ${filterOptions[selectedFilter]}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        );
    }
  }

  void _clearAllFilters() {
    setState(() {
      filterStates = {
        'brands': <String>[],
        'subcategory': '',
        'occasion': '',
        'size': '',
        'color': '',
        'priceRange': RangeValues(0, 10000),
        'trend': '',
        'pattern': '',
        'fabric': '',
        'sleeveLength': '',
      };
    });
  }

  List<Map<String, dynamic>> get filteredProducts {
    // Apply filters based on current filter states
    List<Map<String, dynamic>> filtered = List.from(products);

    // Apply brand filter
    if (filterStates['brands'].isNotEmpty) {
      // In a real app, you'd filter by brand here
      // For demo purposes, we'll keep all products
    }

    // Apply gender filter
    if (selectedGender != 'All') {
      // In a real app, products would have gender property
      // For demo purposes, we'll keep all products
    }

    // Apply sorting
    switch (selectedSort) {
      case 'Price: High to Low':
        filtered.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'Price: Low to High':
        filtered.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'Discount':
        filtered.sort((a, b) =>
            (b['discount'] - b['price']).compareTo(a['discount'] - a['price']));
        break;
      default:
        // Keep original order for 'Recommended' and others
        break;
    }

    return filtered;
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
              delegate: _CategoryHeaderDelegate(
                child: _buildPinnedCategoryText(context),
                minExtent: 44,
                maxExtent: 56,
              ),
            ),
            SliverPersistentHeader(
              delegate: _CategoryHeaderDelegate(
                child: _buildFilterTabs(context),
                minExtent: 56,
                maxExtent: 64,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.56,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      product: product,
                      isWishlist: false,
                    );
                  },
                  childCount: filteredProducts.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
}

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minExtent;
  final double maxExtent;

  _CategoryHeaderDelegate({
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
  bool shouldRebuild(_CategoryHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}
