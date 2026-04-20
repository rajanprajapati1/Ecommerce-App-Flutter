// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

import '../widget/product_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> cartProducts = [
    {
      'name': 'Oversized Hoodie',
      'desc': 'Comfortable and stylish',
      'price': 999,
      'discount': 258,
      'image': 'assets/images/hodie_three.png',
    },
    {
      'name': 'Cargo Pants',
      'desc': 'Trendy utility wear',
      'price': 1199,
      'discount': 250,
      'image': 'assets/images/cargo_c.png',
    },
  ];

  final coupon = {
    'code': 'SAVE200',
    'desc': 'Get ₹200 off on orders above ₹999',
    'expiry': 'Valid till 31 Aug',
  };

  bool couponApplied = false;

  final List<String> recCategories = [
    'Top Wear',
    'Bottom Wear',
    'Footwear',
    'Accessories'
  ];
  int selectedRecCategory = 0;
  final Map<String, List<Map<String, dynamic>>> recommendedProducts = {
    'Top Wear': [
      {
        'name': 'T-Shirt',
        'desc': 'Cotton, round neck',
        'price': 499,
        'discount': 6555,
        'image': 'assets/images/hodie_one.png',
      },
      {
        'name': 'Shirt',
        'desc': 'Formal, slim fit',
        'price': 799,
        'discount': 2500,
        'image': 'assets/images/l_d_one.png',
      },
      {
        'name': 'Polo T-Shirt',
        'desc': 'Cotton, breathable',
        'price': 599,
        'discount': 2555,
        'image': 'assets/images/l_d_two.png',
      }
    ],
    'Bottom Wear': [
      {
        'name': 'Jeans',
        'desc': 'Blue denim',
        'price': 999,
        'discount': 2000,
        'image': 'assets/images/offer_three.png',
      },
      {
        'name': 'Shorts',
        'desc': 'Casual wear',
        'price': 399,
        'discount': 3000,
        'image': 'assets/images/t_shirt_one.png',
      },
    ],
    'Footwear': [
      {
        'name': 'Sneakers',
        'desc': 'White, trendy',
        'price': 1299,
        'discount': 5000,
        'image': 'assets/images/v_banner.png',
      },
      {
        'name': 'Sandals',
        'desc': 'Comfortable',
        'price': 599,
        'discount': 1588,
        'image': 'assets/images/v_three.png',
      },
    ],
    'Accessories': [
      {
        'name': 'Watch',
        'desc': 'Analog, stylish',
        'price': 1499,
        'discount': 3215,
        'image': 'assets/images/v_two_banner.png',
      },
      {
        'name': 'Sunglasses',
        'desc': 'UV protected',
        'price': 799,
        'discount': 1587,
        'image': 'assets/images/offer_one.png',
      },
    ],
  };

  int selectedDelivery = 0; // 0: Try'n Buy, 1: Standard

  late TabController _tabController;
  late ScrollController _scrollController;
  bool _showAddressBar = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: recCategories.length, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showAddressBar) setState(() => _showAddressBar = false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showAddressBar) setState(() => _showAddressBar = true);
    }
  }

  void _showCouponAppliedDialog(BuildContext context, int savingsAmount) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon with circle background
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green.shade600,
                    size: 45,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "'KNOTIK' applied",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  '₹$savingsAmount savings with this coupon',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'YAY!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                // Decorative confetti dots
                Wrap(
                  spacing: 12,
                  children: [
                    _buildConfettiShape(Colors.purple, Icons.star),
                    _buildConfettiShape(Colors.green, Icons.circle),
                    _buildConfettiShape(Colors.blue, Icons.change_history),
                    _buildConfettiShape(Colors.red, Icons.favorite),
                    _buildConfettiShape(Colors.orange, Icons.circle),
                    _buildConfettiShape(Colors.pink, Icons.star),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfettiShape(Color color, IconData icon) {
    return Icon(icon, color: color, size: 16);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalMRP =
        cartProducts.fold<int>(0, (sum, item) => sum + (item['price'] as int));
    final discount = couponApplied ? 200 : 0;
    final couponDiscount = couponApplied ? 100 : 0;
    final total = totalMRP - discount - couponDiscount;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(Theme.of(context)),
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _showAddressBar ? 48 : 0,
                curve: Curves.easeInOut,
                child: Opacity(
                  opacity: _showAddressBar ? 1.0 : 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Deliver to: 123 Main Street, Mumbai',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            // Change address logic
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceVariant
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: Colors.indigo,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Free Delivery in',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        '60 minutes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹$total',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Cart products vertical list
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final product = cartProducts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            child: Image.asset(
                                              product['image'],
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(product['name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                const Spacer(),
                                                Text('₹${product['price']}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(product['desc'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                                const Spacer(),
                                                Text(
                                                  '₹${product['discount']}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.5),
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                // Size Container
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surfaceVariant
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text('Size',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const SizedBox(width: 4),
                                                      Text('M',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium),
                                                      const SizedBox(width: 4),
                                                      Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 20),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                // Quantity Container
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surfaceVariant
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Decrement logic
                                                        },
                                                        child: const Icon(
                                                            Icons.remove,
                                                            size: 20),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text('1',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium),
                                                      const SizedBox(width: 8),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Increment logic
                                                        },
                                                        child: const Icon(
                                                            Icons.add,
                                                            size: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                // Size Container
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surfaceVariant
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text('Size',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const SizedBox(width: 4),
                                                      Text('M',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium),
                                                      const SizedBox(width: 4),
                                                      Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 20),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                // Quantity Container
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surfaceVariant
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Decrement logic
                                                        },
                                                        child: const Icon(
                                                            Icons.remove,
                                                            size: 20),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text('1',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium),
                                                      const SizedBox(width: 8),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Increment logic
                                                        },
                                                        child: const Icon(
                                                            Icons.add,
                                                            size: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: [
                                      Text("Try'n BUY",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.5),
                                              fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.favorite_border_sharp,
                                            size: 24),
                                        onPressed: () {
                                          // Add to wishlist logic
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      // filepath: d:\prasad\AndroidStudioProjects\knotnow\knot\lib\screens\cart_screen.dart
// ...existing code...

                      const SizedBox(height: 16),

// Green savings banner (show when coupon is applied)
                      if (couponApplied)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.green.shade300, width: 1.5),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '₹${couponDiscount + discount} saved! on this order',
                                  style: TextStyle(
                                    color: Colors.green.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      if (couponApplied) const SizedBox(height: 12),

// Coupon section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.local_offer,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  size: 22,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  coupon['code']!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(coupon['desc']!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                            const SizedBox(height: 4),
                                            Text(coupon['expiry']!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.green)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (!couponApplied) {
                                          // Show success dialog first
                                          _showCouponAppliedDialog(
                                              context, couponDiscount);
                                          // Then update state after a brief delay
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              couponApplied = true;
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            couponApplied = false;
                                          });
                                        }
                                      },
                                      child: Text(
                                        couponApplied ? 'Remove' : 'Apply',
                                        style: TextStyle(
                                          color: couponApplied
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .error
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Show all coupons logic
                                    },
                                    child: Text(
                                      'See all coupons',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

// ...existing code...
                      const SizedBox(height: 16),
                      // Recommendation section
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Style it with',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).highlightColor,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recCategories.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 5),
                                  itemBuilder: (context, index) {
                                    final isSelected =
                                        selectedRecCategory == index;
                                    return GestureDetector(
                                      onTap: () => setState(
                                          () => selectedRecCategory = index),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .surfaceVariant
                                                  .withOpacity(0.5)
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .surfaceVariant
                                                  .withOpacity(0.5),
                                          border: isSelected
                                              ? Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  width: 2,
                                                )
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          recCategories[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 370,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recommendedProducts[recCategories[
                                              selectedRecCategory]]
                                          ?.length ??
                                      0,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final product = recommendedProducts[
                                        recCategories[
                                            selectedRecCategory]]![index];
                                    return SizedBox(
                                      width: 180,
                                      child: ProductCard(
                                        product: product,
                                        isCart: true,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(height: 100),
                      // Delivery options
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Delivery Option',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            _deliveryOption(
                              context,
                              selected: selectedDelivery == 0,
                              onTap: () => setState(() => selectedDelivery = 0),
                              title: "Try'n Buy",
                              points: [
                                "Try before you buy at your doorstep.",
                                "Easy returns within 7 days.",
                              ],
                              bottomText: "How it works",
                            ),
                            const SizedBox(height: 12),
                            _deliveryOption(
                              context,
                              selected: selectedDelivery == 1,
                              onTap: () => setState(() => selectedDelivery = 1),
                              title: "Standard",
                              points: [
                                "Fast delivery in 2-4 days.",
                                "Free shipping above ₹999.",
                              ],
                              bottomText: "₹49 Delivery Fee",
                            ),
                          ],
                        ),
                      ),
                      // Coupon savings above price details
                      if (couponApplied) SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet,
                                color: Colors.green),
                            const SizedBox(width: 8),
                            Text('₹200 saved! on this order',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                      ),
                      // Price details section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total MRP'),
                                    Text('₹$totalMRP')
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Discount'),
                                    Text('-₹$discount'),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Coupon Discount'),
                                    Text('-₹$couponDiscount'),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                    Text('₹$total',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
              // BottomSheet with two buttons
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border(
                        top: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.5))),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: Icon(Icons.calendar_today,
                              color: Theme.of(context).colorScheme.primary),
                          label: const Text('Now',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {},
                          child: const Text('Place Order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: kToolbarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Your Bag',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/wishlist');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _deliveryOption(
    BuildContext context, {
    required bool selected,
    required VoidCallback onTap,
    required String title,
    required List<String> points,
    required String bottomText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: selected
                      ? Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            ...points.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: Colors.green, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                          child: Text(p,
                              style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            Text(bottomText,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
