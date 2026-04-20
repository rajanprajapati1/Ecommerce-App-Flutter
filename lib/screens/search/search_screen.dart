// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widget/product_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final List<String> pastSearches = [
    'Wishlist',
  ];

  final List<String> popularSearches = [
    'Relaxed Joggers',
    'Street Shorts',
    'Urban Tees',
    'Oversized Hoodie',
  ];

  final List<Map<String, dynamic>> recentlyViewed = [
    {
      'name': 'WHAT THE FLEX',
      'desc': 'ROUGH TRADE Varsity Jacket',
      'price': 2999,
      'discount': 2499,
      'image': 'assets/images/hodie_three.png',
    },
    {
      'name': 'Veirdo',
      'desc': 'Cotton Polly Fleece Regular',
      'price': 1999,
      'discount': 899,
      'image': 'assets/images/v_three.png',
    },
    {
      'name': 'Denim Jacket',
      'desc': 'Classic Blue Denim',
      'price': 2499,
      'discount': 1999,
      'image': 'assets/images/offer_four.png',
    },
    {
      'name': 'Graphic Tee',
      'desc': 'Trendy and Comfortable',
      'price': 999,
      'discount': 799,
      'image': 'assets/images/t_shirt_three.png',
    },
    {
      'name': 'Chinos',
      'desc': 'Casual and Stylish',
      'price': 1499,
      'discount': 1199,
      'image': 'assets/images/v_two_banner.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              color: theme.colorScheme.onSecondary
                                  .withOpacity(0.5)),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                                color: theme.colorScheme.onSecondary
                                    .withOpacity(0.5)),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for 'Baggy jeans'",
                              hintStyle: TextStyle(
                                  color: theme.colorScheme.onSecondary
                                      .withOpacity(0.5)),
                              isDense: true,
                            ),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          const SizedBox(height: 8),
          Text('Your past searches',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: pastSearches
                .map((s) => Chip(
                      label: Text(s,
                          style: TextStyle(
                            color: theme.colorScheme.onSecondary,
                          )),
                      backgroundColor: Theme.of(context).colorScheme.onTertiary,
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Text('Popular searches',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: popularSearches
                .map((s) => Chip(
                      label: Text(s,
                          style:
                              TextStyle(color: theme.colorScheme.onSecondary)),
                      backgroundColor: Theme.of(context).colorScheme.onTertiary,
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          Text('Recently Viewed',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 320,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyViewed.length,
              separatorBuilder: (_, __) => const SizedBox(width: 0),
              itemBuilder: (context, idx) {
                return SizedBox(
                  width: 180,
                  child: ProductCard(product: recentlyViewed[idx]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
