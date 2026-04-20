// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app_theme_mode.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showAppearanceBottomSheet(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appearance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Column(
                  children: [
                    _ThemeOption(
                      icon: Icons.light_mode,
                      title: 'Light theme',
                      isSelected:
                          themeController.themeMode.value == ThemeMode.light,
                      onTap: () => themeController.setTheme(AppThemeMode.light),
                    ),
                    const SizedBox(height: 12),
                    _ThemeOption(
                      icon: Icons.dark_mode,
                      title: 'Dark theme',
                      isSelected:
                          themeController.themeMode.value == ThemeMode.dark,
                      onTap: () => themeController.setTheme(AppThemeMode.dark),
                    ),
                    const SizedBox(height: 12),
                    _ThemeOption(
                      icon: Icons.phone_android,
                      title: 'Use device theme',
                      isSelected:
                          themeController.themeMode.value == ThemeMode.system,
                      onTap: () =>
                          themeController.setTheme(AppThemeMode.system),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
          ],
        ),
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF888A93), Color(0xFFBFC1C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Prasad',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  const Text('Lvl 00',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  const Text('Level Progress',
                      style: TextStyle(fontSize: 13, color: Colors.white)),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        height: 8,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('₹0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white)),
                      const Text('₹10,000',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total spent',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                      const Text('Lvl 01',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Order Count & Knot Cash
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.inventory_2_outlined,
                              size: 28,
                              color: Colors.transparent,
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.inventory_2_outlined, size: 28),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text('Order Count',
                            style: TextStyle(
                                fontSize: 13,
                                color: theme.colorScheme.primary)),
                        const SizedBox(height: 2),
                        Text('0',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.inventory_2_outlined,
                              size: 28,
                              color: Colors.transparent,
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 28,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text('Knot cash',
                            style: TextStyle(
                                fontSize: 13,
                                color: theme.colorScheme.primary)),
                        const SizedBox(height: 2),
                        Text('₹0',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Main Actions
            Container(
              margin: const EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 2.8,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: [
                        _ProfileActionButton(
                          icon: Icons.list_alt,
                          label: 'My Orders',
                          onTap: () {},
                        ),
                        _ProfileActionButton(
                          icon: Icons.help_outline,
                          label: 'Help & Query',
                          onTap: () {},
                        ),
                        _ProfileActionButton(
                          icon: Icons.favorite_border,
                          label: 'Wishlist',
                          onTap: () {},
                        ),
                        _ProfileActionButton(
                          icon: Icons.card_giftcard,
                          label: 'Refer & Earn',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),
            // Other Options
            Container(
              margin: const EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _ProfileOption(
                    icon: Icons.color_lens_outlined,
                    label: 'Appearance',
                    onTap: () => _showAppearanceBottomSheet(context),
                  ),
                  _ProfileOption(
                    icon: Icons.person_outline,
                    label: 'Manage Account',
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.location_on_outlined,
                    label: 'Addresses',
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.local_offer_outlined,
                    label: 'My Offers',
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.article_outlined,
                    label: 'Terms & Conditions',
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.privacy_tip_outlined,
                    label: 'Privacy Policy',
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.logout,
                    label: 'Logout',
                    iconColor: Colors.red,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ProfileActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.highlightColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Icon(icon, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  const _ProfileOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: iconColor,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w500, color: iconColor),
              ),
            ),
            Icon(Icons.chevron_right, size: 22, color: iconColor),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.blue : theme.iconTheme.color,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Colors.blue
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey,
                  width: 2,
                ),
                color: isSelected ? Colors.blue : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
