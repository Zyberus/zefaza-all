import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../profile/screens/orders_screen.dart';
import '../../profile/screens/wishlist_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../../core/services/auth_service.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate the height of the navigation bar plus some extra padding
    final bottomPadding = MediaQuery.of(context).padding.bottom + 100;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Column(
          children: [
            _buildUserHeader(),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            const SizedBox(height: 16),
            _buildMainMenu(context),
            const SizedBox(height: 16),
            _buildAccountSettings(),
            const SizedBox(height: 16),
            _buildAppSettings(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Menu',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black87),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildUserHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlack,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello, John',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Prime Member',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

    Widget _buildQuickActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              'Your Orders',
              '5 recent orders',
              Icons.shopping_bag_outlined,
              Colors.blue[600]!,
               () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => const OrdersScreen(),
                   ),
                 );
               },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              'Buy Again',
              'Reorder favorites',
              Icons.refresh,
              Colors.green[600]!,
              () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMenu(BuildContext context) {
    return _buildMenuSection(
      'Shop by Department',
      [
        _buildMenuItem(
          'Your Orders',
          'Track, return, or buy again',
          Icons.shopping_bag_outlined,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrdersScreen(),
              ),
            );
          },
        ),
        _buildMenuItem(
          'Your Wishlist',
          'View saved for later',
          Icons.favorite_border,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WishlistScreen(),
              ),
            );
          },
        ),
        _buildMenuItem(
          'Your Recommendations',
          'Discover new items',
          Icons.recommend,
          () {},
        ),
        _buildMenuItem(
          'Buy Again',
          'See your recurring purchases',
          Icons.refresh,
          () {},
        ),
        _buildMenuItem(
          'Browsing History',
          'Edit or view your history',
          Icons.history,
          () {},
        ),
        _buildMenuItem(
          'Your Lists',
          'Shopping and wish lists',
          Icons.list_alt,
          () {},
        ),
      ],
    );
  }

  Widget _buildAccountSettings() {
    return _buildMenuSection(
      'Your Account',
      [
        _buildMenuItem(
          'Manage Your Account',
          'Login & security, Prime, addresses',
          Icons.person_outline,
          () {},
        ),
        _buildMenuItem(
          'Payment Options',
          'Manage payment methods & settings',
          Icons.credit_card,
          () {},
        ),
        _buildMenuItem(
          'Prime Membership',
          'View benefits and payment settings',
          Icons.stars,
          () {},
        ),
        _buildMenuItem(
          'Your Addresses',
          'Edit addresses for orders and gifts',
          Icons.location_on_outlined,
          () {},
        ),
        _buildMenuItem(
          'Digital Content & Devices',
          'Manage content and devices',
          Icons.devices,
          () {},
        ),
      ],
    );
  }

  Widget _buildAppSettings(BuildContext context) {
    return _buildMenuSection(
      'App Settings',
      [
        _buildMenuItem(
          'Settings',
          'Notifications, country & language',
          Icons.settings_outlined,
          () {},
        ),
        _buildMenuItem(
          'Customer Service',
          'Help & customer service',
          Icons.help_outline,
          () {},
        ),
        _buildMenuItem(
          'Send Feedback',
          'Tell us what you think',
          Icons.feedback_outlined,
          () {},
        ),
        _buildMenuItem(
          'Legal & About',
          'Terms, privacy & more',
          Icons.info_outline,
          () {},
        ),
        _buildMenuItem(
          'Sign Out',
          '',
          Icons.logout,
          () {
            AuthService().logout();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You have been signed out'),
                backgroundColor: Colors.green,
              ),
            );
          },
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isDestructive ? Colors.red[600] : Colors.grey[700],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDestructive ? Colors.red[600] : Colors.black87,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isDestructive)
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
} 