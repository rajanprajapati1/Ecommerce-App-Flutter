// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../widget/product_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

final List<String> images = [
  'assets/images/hodie_one.png',
  'assets/images/hodie_two.png',
  'assets/images/hodie_one.png',
  'assets/images/jeans_c.png',
  'assets/images/l_d_three.png',
];

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int selectedImage = 0;
  late TabController _tabController;
  bool descExpanded = false;

  double _swipeOffset = 0.0;

  final Map<String, String> specs = {
    'Material': 'Alloy',
    'Weight': '180 Grams',
    'Design': 'Minimal',
    'Warranty': 'No Warranty',
  };

  final List<Map<String, dynamic>> edit90List = [
    {
      'name': 'Oversized Hoodie',
      'desc': 'Comfortable and stylish',
      'price': 1299,
      'discount': 999,
      'image': 'assets/images/hodie_two.png',
    },
    {
      'name': 'Cargo Pants',
      'desc': 'Trendy utility wear',
      'price': 1599,
      'discount': 1199,
      'image': 'assets/images/cargo_c.png',
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
      'image': 'assets/images/offer_four.png',
    },
  ];

  final String description =
      "The Machina Chain Bracelet - Metallic Silver\n\nA bold, minimal accessory for every occasion. Crafted from premium alloy, this chain bracelet is designed for durability and style. Wear it solo or stack it for a statement look. Non returnable. Secure payment.";
  List<Map<String, dynamic>> styleProducts = [
    {
      'name': 'Wave Funky Fusion Chain',
      'desc': 'Silver, bold style',
      'image': images[1],
      'price': 499,
      'strike': 999,
    },
    {
      'name': 'Minimalist Ring',
      'desc': 'Classic, stackable',
      'image': images[2],
      'price': 299,
      'strike': 499,
    },
    {
      'name': 'Charm Bracelet',
      'desc': 'Trendy, adjustable',
      'image': images[3],
      'price': 399,
      'strike': 799,
    },
  ];
  Set<int> selectedStyleIndexes = {};
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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

  Widget _buildImageSection(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, top: 12, bottom: 0),
      child: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 9 / 12.5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.onSecondary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      images[selectedImage],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 400,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.favorite_border,
                            color: theme.colorScheme.onSecondary),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.share,
                            color: theme.colorScheme.onSecondary),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, idx) => GestureDetector(
                      onTap: () => setState(() => selectedImage = idx),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedImage == idx
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            images[idx],
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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

  Widget _buildSwipeableBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = constraints.maxWidth;
        final buttonWidth = 56.0; // Reduced button size
        final centerPosition = (containerWidth - buttonWidth) / 2;

        final double swipeProgress = _swipeOffset / centerPosition;

        // Fixed: For left swipe: swipeProgress < 0, for right swipe: swipeProgress > 0
        // When swiping left (negative offset), show left animation bright
        // When swiping right (positive offset), show right animation bright
        double leftActive =
            (-swipeProgress).clamp(0, 1); // 1 when swiping left, 0 otherwise
        double rightActive =
            swipeProgress.clamp(0, 1); // 1 when swiping right, 0 otherwise

        return Container(
          height: 65,
          decoration: BoxDecoration(
            color: isDark ? Color(0xFF333333) : Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: theme.colorScheme.onSecondary.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              // BUY NOW label (left corner) - gets brighter when swiping left
              Positioned(
                left: 18,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    'BUY NOW',
                    style: TextStyle(
                      color: Color.lerp(
                          theme.colorScheme.onSecondary.withOpacity(0.6),
                          theme.colorScheme.onSecondary,
                          leftActive),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // ADD TO BAG label (right corner) - gets brighter when swiping right
              Positioned(
                right: 18,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    'ADD TO BAG',
                    style: TextStyle(
                      color: Color.lerp(
                          theme.colorScheme.onSecondary.withOpacity(0.6),
                          theme.colorScheme.onSecondary,
                          rightActive),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // Swipeable button
              AnimatedPositioned(
                duration: const Duration(milliseconds: 80),
                left: centerPosition + _swipeOffset,
                top: 1,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _swipeOffset += details.delta.dx;
                      _swipeOffset = _swipeOffset.clamp(
                          -centerPosition + 4, centerPosition - 4);
                    });
                  },
                  onPanEnd: (details) {
                    if (_swipeOffset > centerPosition * 0.2) {
                      _onAddToBag();
                    } else if (_swipeOffset < -centerPosition * 0.2) {
                      _onBuyNow();
                    }
                    setState(() {
                      _swipeOffset = 0.0;
                    });
                  },
                  child: Container(
                    width: buttonWidth,
                    height: 56,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                ),
              ),
              // Swipe indicators (chevrons) - Left side indicators
              Positioned(
                left: 100,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: Color.lerp(
                            theme.colorScheme.onSecondary.withOpacity(0.2),
                            theme.colorScheme.primary,
                            leftActive),
                        size: 16,
                      ),
                      Icon(
                        Icons.chevron_left,
                        color: Color.lerp(
                            theme.colorScheme.onSecondary.withOpacity(0.3),
                            theme.colorScheme.primary,
                            leftActive),
                        size: 18,
                      ),
                      Icon(
                        Icons.chevron_left,
                        color: Color.lerp(
                            theme.colorScheme.onSecondary.withOpacity(0.4),
                            theme.colorScheme.primary,
                            leftActive),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              // Swipe indicators (chevrons) - Right side indicators
              Positioned(
                right: 100,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.chevron_right,
                        color: Color.lerp(
                            theme.colorScheme.onSecondary.withOpacity(0.4),
                            theme.colorScheme.primary,
                            rightActive),
                        size: 20,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color.lerp(
                            theme.colorScheme.onSecondary.withOpacity(0.3),
                            theme.colorScheme.primary,
                            rightActive),
                        size: 18,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color.lerp(
                            theme.colorScheme.onSecondary.withOpacity(0.2),
                            theme.colorScheme.primary,
                            rightActive),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onBuyNow() {
    // Handle buy now action
  }

  void _onAddToBag() {
    // Handle add to bag action
  }

  Widget _buildInfoSection(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column: Name & Description
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'French Accent',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: theme.colorScheme.onSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  'The Machina Chain Bracelet - Metallic Silver',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSecondary.withOpacity(0.5),
                      ),
                ),
              ],
            ),
          ),
          // Right column: Price
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹599',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: theme.colorScheme.onSecondary),
                ),
                const SizedBox(height: 2),
                Text(
                  '₹898',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSecondary.withOpacity(0.5),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '33% off',
                    style: TextStyle(
                        color: theme.colorScheme.onPrimary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Size',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildSizeOption(context, 'S'),
              const SizedBox(width: 12),
              _buildSizeOption(context, 'M'),
              const SizedBox(width: 12),
              _buildSizeOption(context, 'L'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabsSection(BuildContext context) {
    final theme = Theme.of(context);
    final double collapsedHeight = 100;
    final double expandedHeight = 220;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            controller: _tabController,
            indicatorColor: theme.colorScheme.onSecondary,
            labelColor: theme.colorScheme.onSecondary,
            unselectedLabelColor:
                theme.colorScheme.onSecondary.withOpacity(0.7),
            tabs: const [
              Tab(text: 'SPECIFICATION'),
              Tab(text: 'DESCRIPTION'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: descExpanded ? expandedHeight : collapsedHeight,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Specification Tab
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 2.2,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: specs.entries.map((e) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  e.key,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  e.value,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // Description Tab
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 300),
                              crossFadeState: descExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Text(
                                description.length > 120
                                    ? '${description.substring(0, 120)}...'
                                    : description,
                                style: const TextStyle(fontSize: 14),
                              ),
                              secondChild: Text(
                                description,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: theme.dividerColor.withOpacity(0.3),
          ),
          if (description.length > 120)
            SizedBox(
              height: 38,
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(80, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => setState(() => descExpanded = !descExpanded),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        descExpanded ? 'View less' : 'View more',
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Icon(
                        descExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: theme.colorScheme.onSecondary,
                        size: 22,
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

  Widget _buildSizeOption(BuildContext context, String size) {
    final theme = Theme.of(context);
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
            color: theme.colorScheme.onSecondary.withOpacity(0.3), width: 1),
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          size,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildStyleItWith(BuildContext context) {
    final theme = Theme.of(context);
    final int selectedCount = selectedStyleIndexes.length + 1;
    final int selectedTotal = styleProducts
        .asMap()
        .entries
        .where((e) => selectedStyleIndexes.contains(e.key))
        .fold(
            599,
            (sum, e) =>
                sum +
                (e.value['price'] as int)); // 599 is current product price

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Style It With',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSecondary,
                  fontSize: 18)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: theme.colorScheme.tertiary.withOpacity(0.9)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current product card
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Container(
                    width: 150,
                    height: 280,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.asset(
                            images[selectedImage],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('French Accent',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              SizedBox(height: 2),
                              Text('The Machina Chain Bracelet',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Center + icon
                Container(
                  width: 50,
                  height: 280,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
                // Style products vertical list
                Expanded(
                  child: SizedBox(
                    width: 140,
                    height: 320,
                    child: ListView.separated(
                      itemCount: styleProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, idx) {
                        final prod = styleProducts[idx];
                        final selected = selectedStyleIndexes.contains(idx);
                        return Stack(
                          children: [
                            Container(
                              height: 285,
                              width: 150,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceVariant
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    child: Image.asset(
                                      prod['image'],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('₹${prod['price']}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                            const SizedBox(width: 6),
                                            Text('₹${prod['strike']}',
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white54,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                          ],
                                        ),
                                        Text(prod['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                        Text(prod['desc'],
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.white70)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Checkbox
                            Positioned(
                              right: 15,
                              bottom: 60,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selected) {
                                      selectedStyleIndexes.remove(idx);
                                    } else {
                                      selectedStyleIndexes.add(idx);
                                    }
                                  });
                                },
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: selected
                                          ? theme.colorScheme.primary
                                          : Colors.white54,
                                      width: 2,
                                    ),
                                    color: selected
                                        ? theme.colorScheme.primary
                                        : Colors.transparent,
                                  ),
                                  child: selected
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 16)
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: selectedStyleIndexes.isEmpty
                  ? theme.colorScheme.surfaceVariant.withOpacity(0.7)
                  : theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: selectedStyleIndexes.isEmpty
                ? const Text(
                    'Select items to style your outfit',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                : Text(
                    'Add $selectedCount Products | ₹$selectedTotal',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProducts(BuildContext context) {
    final theme = Theme.of(context);
    final int selectedCount = selectedStyleIndexes.length + 1;
    final int selectedTotal = styleProducts
        .asMap()
        .entries
        .where((e) => selectedStyleIndexes.contains(e.key))
        .fold(
            599,
            (sum, e) =>
                sum +
                (e.value['price'] as int)); // 599 is current product price

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Similar Products",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSecondary),
          ),
        ),
        SizedBox(
          height: 320,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
    );
  }

  Widget _buildInfoIcons(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.verified_user,
                  color: theme.colorScheme.onSecondary, size: 28),
              SizedBox(height: 4),
              Text('Secure payment',
                  style: TextStyle(
                      color: theme.colorScheme.onSecondary, fontSize: 13)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.block, color: theme.colorScheme.onSecondary, size: 28),
              SizedBox(height: 4),
              Text('Non returnable',
                  style: TextStyle(
                      color: theme.colorScheme.onSecondary, fontSize: 13)),
            ],
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
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          ListView(
            padding:
                const EdgeInsets.only(bottom: 110), // Increased bottom padding
            children: [
              _buildImageSection(context),
              const SizedBox(height: 25),
              _buildInfoSection(context),
              _buildSizeSection(context),
              _buildTabsSection(context),
              _buildInfoIcons(context),
              _buildStyleItWith(context),
              _buildSimilarProducts(context),
              const SizedBox(height: 24),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? Color(0xFF272727) : Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                padding: const EdgeInsets.only(
                    bottom: 18, top: 18, left: 10, right: 10),
                child: _buildSwipeableBottomBar(context),
              )),
        ],
      ),
    );
  }
}
