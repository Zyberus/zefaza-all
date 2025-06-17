import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildProfileInfo(),
              _buildMenu(),
              _buildAppVersion(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
              letterSpacing: 0.5,
            ),
          ),
          IconButton(
            onPressed: () {
              // Edit profile
            },
            icon: Icon(
              Icons.edit_outlined,
              color: AppTheme.accentColor,
              size: 24,
            ),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Profile image
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppTheme.accentColor.withOpacity(0.2),
                child: const CircleAvatar(
                  radius: 48,
                  backgroundColor: AppTheme.cardColor,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.cardColor,
                      width: 2,
                    ),
                  ),
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Name
          const Text(
            'John Smith',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            'johnsmith@example.com',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Stats
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProfileStat('Deliveries', '158'),
                _buildProfileStat('Rating', '4.8'),
                _buildProfileStat('Member Since', 'Jan 2023'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.accentColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            'Account Settings',
            Icons.person_outline,
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            'Payment Methods',
            Icons.credit_card_outlined,
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            'Vehicle Information',
            Icons.motorcycle_outlined,
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            'Documents',
            Icons.description_outlined,
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            'Notification Settings',
            Icons.notifications_outlined,
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            'Privacy & Security',
            Icons.security_outlined,
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            'Help & Support',
            Icons.help_outline,
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            'Log Out',
            Icons.logout_outlined,
            textColor: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon, {
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: textColor ?? AppTheme.accentColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? AppTheme.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: Colors.grey[850],
    );
  }

  Widget _buildAppVersion() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Icon(
            Icons.delivery_dining,
            color: AppTheme.accentColor.withOpacity(0.5),
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            'Zefaza Delivery',
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
} 