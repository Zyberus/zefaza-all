import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../auth/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = _authService.isLoggedIn;
    
    // Calculate bottom padding to account for the navigation bar
    final bottomPadding = MediaQuery.of(context).padding.bottom + 100;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Column(
            children: [
              _buildHeader(isLoggedIn),
              const SizedBox(height: 16),
              if (isLoggedIn) ...[
                _buildProfileStats(),
                const SizedBox(height: 16),
                _buildMenuSection('Account', _accountMenuItems),
                const SizedBox(height: 16),
                _buildMenuSection('Shopping', _shoppingMenuItems),
                const SizedBox(height: 16),
                _buildMenuSection('Support', _supportMenuItems),
                const SizedBox(height: 16),
                _buildSignOutButton(),
              ] else ...[
                _buildLoginPrompt(),
              ],
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLoggedIn) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              // Profile Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoggedIn) ...[
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'john.doe@email.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlack,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Premium Member',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sign in to access your account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Edit Button (only shown if logged in)
              if (isLoggedIn)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.account_circle_outlined,
            size: 60,
            color: AppTheme.primaryBlack,
          ),
          const SizedBox(height: 16),
          const Text(
            'Sign in to your account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Access your orders, wishlist, and personalized recommendations',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              ).then((_) {
                // Refresh the screen when returning from login
                setState(() {});
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlack,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          Expanded(child: _buildStatItem('Orders', '24')),
          Container(width: 1, height: 40, color: Colors.grey[300]),
          Expanded(child: _buildStatItem('Saved', '12')),
          Container(width: 1, height: 40, color: Colors.grey[300]),
          Expanded(child: _buildStatItem('Reviews', '8')),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Map<String, dynamic>> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          ...items.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> item = entry.value;
            bool isLast = index == items.length - 1;
            
            return _buildMenuItem(
              item['title'],
              item['icon'],
              item['trailing'],
              showDivider: !isLast,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    Widget? trailing, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: Colors.grey[700],
            size: 20,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: trailing ?? 
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 20,
            ),
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          minLeadingWidth: 24,
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: Colors.grey[200],
            indent: 52,
          ),
      ],
    );
  }

  Widget _buildSignOutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () async {
          await _authService.logout();
          setState(() {});
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.red[700],
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static final List<Map<String, dynamic>> _accountMenuItems = [
    {
      'title': 'Personal Information',
      'icon': Icons.person_outline,
      'trailing': null,
    },
    {
      'title': 'Addresses',
      'icon': Icons.location_on_outlined,
      'trailing': null,
    },
    {
      'title': 'Payment Methods',
      'icon': Icons.payment_outlined,
      'trailing': null,
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications_outlined,
      'trailing': Switch(
        value: true,
        onChanged: (value) {},
        activeColor: AppTheme.primaryBlack,
      ),
    },
  ];

  static final List<Map<String, dynamic>> _shoppingMenuItems = [
    {
      'title': 'Order History',
      'icon': Icons.history,
      'trailing': null,
    },
    {
      'title': 'Wishlist',
      'icon': Icons.favorite_outline,
      'trailing': null,
    },
    {
      'title': 'Reviews & Ratings',
      'icon': Icons.star_outline,
      'trailing': null,
    },
    {
      'title': 'Store Preferences',
      'icon': Icons.store_outlined,
      'trailing': null,
    },
  ];

  static final List<Map<String, dynamic>> _supportMenuItems = [
    {
      'title': 'Help Center',
      'icon': Icons.help_outline,
      'trailing': null,
    },
    {
      'title': 'Contact Us',
      'icon': Icons.message_outlined,
      'trailing': null,
    },
    {
      'title': 'Privacy Policy',
      'icon': Icons.privacy_tip_outlined,
      'trailing': null,
    },
    {
      'title': 'Terms of Service',
      'icon': Icons.description_outlined,
      'trailing': null,
    },
  ];
} 