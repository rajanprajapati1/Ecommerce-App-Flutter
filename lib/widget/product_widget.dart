// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool? isCart;
  final bool? isWishlist;
  const ProductCard(
      {super.key, required this.product, this.isCart, this.isWishlist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        // Navigate to product details screen
        context.push('/product');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Material(
          color: Theme.of(context).colorScheme.onTertiary,
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 230,
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
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(product['name'],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 0),
                        Text(product['desc'],
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            )),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text('₹${product['discount']}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            const SizedBox(width: 5),
                            Text('₹${product['price']}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    decoration: TextDecoration.lineThrough)),
                            const SizedBox(width: 5),
                            Text('20% off',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        if (isCart == true)
                          SizedBox(
                            height: 10,
                          ),
                        if (isCart == true)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceBright
                                      .withOpacity(0.9),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline
                                        .withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: GestureDetector(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Add to Cart'),
                                    ),
                                  ),
                                  onTap: () {
                                    // Add your add-to-cart logic here
                                  },
                                )),
                          ),
                        if (isWishlist == true) SizedBox(height: 10),
                        if (isWishlist == true)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.onSurfaceVariant
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: GestureDetector(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 6.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                color: theme
                                                    .colorScheme.onSecondary,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                    color: theme.colorScheme
                                                        .onSecondary,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        // Add your add-to-cart logic here
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onSurfaceVariant
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: theme.colorScheme.onSecondary,
                                      ),
                                      onPressed: () {
                                        // Add your share logic here
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Try'n ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 106, 128, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const Text(
                        "Buy",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    icon: (isWishlist == true)
                        ? Icon(Icons.favorite, color: Colors.white)
                        : Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
