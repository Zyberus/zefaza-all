import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(context),
              _buildStorePerformance(context),
              _buildSettingsSection(context),
              _buildHelpSection(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppTheme.accentColor,
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zefaza Store',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Premium Seller',
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'seller@zefaza.com',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Navigate to edit profile screen
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to store settings
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.cardColor,
              foregroundColor: AppTheme.textColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
              minimumSize: const Size(double.infinity, 0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.storefront, color: AppTheme.accentColor),
                SizedBox(width: 10),
                Text('View My Store'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorePerformance(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Store Performance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              Text(
                'This Month',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildPerformanceMetric(
                Icons.star_rate_rounded,
                Colors.amber,
                '4.8',
                'Rating',
              ),
              _buildPerformanceMetric(
                Icons.shopping_bag,
                Colors.green,
                '98%',
                'Order Fulfillment',
              ),
              _buildPerformanceMetric(
                Icons.schedule,
                Colors.blue,
                '97%',
                'On-Time Delivery',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetric(
    IconData icon,
    Color color,
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ),
          _buildSettingItem(
            Icons.account_circle_outlined,
            'Account Information',
            onTap: () {
              // Navigate to account information screen
            },
          ),
          _buildSettingItem(
            Icons.storefront_outlined,
            'Store Settings',
            onTap: () {
              // Navigate to store settings screen
            },
          ),
          _buildSettingItem(
            Icons.payment_outlined,
            'Payment Methods',
            onTap: () {
              // Navigate to payment methods screen
            },
          ),
          _buildSettingItem(
            Icons.local_shipping_outlined,
            'Shipping Settings',
            onTap: () {
              // Navigate to shipping settings screen
            },
          ),
          _buildSettingItem(
            Icons.notifications_outlined,
            'Notification Preferences',
            onTap: () {
              // Navigate to notification preferences screen
            },
          ),
          _buildSettingItem(
            Icons.security_outlined,
            'Security',
            onTap: () {
              // Navigate to security screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ),
          _buildSettingItem(
            Icons.help_outline,
            'Help Center',
            onTap: () {
              // Navigate to help center screen
            },
          ),
          _buildSettingItem(
            Icons.support_agent_outlined,
            'Contact Support',
            onTap: () {
              // Navigate to contact support screen
            },
          ),
          _buildSettingItem(
            Icons.policy_outlined,
            'Terms & Policies',
            onTap: () {
              // Navigate to terms and policies screen
            },
          ),
          _buildSettingItem(
            Icons.info_outline,
            'About',
            onTap: () {
              // Navigate to about screen
            },
          ),
          _buildSettingItem(
            Icons.logout,
            'Log Out',
            textColor: Colors.red,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title, {
    required Function() onTap,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor ?? Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: textColor ?? AppTheme.textColor,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: textColor ?? Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardColor,
          title: const Text(
            'Log Out',
            style: TextStyle(color: AppTheme.textColor),
          ),
          content: const Text(
            'Are you sure you want to log out of your seller account?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement logout functionality
                // Navigate back to login screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
} 