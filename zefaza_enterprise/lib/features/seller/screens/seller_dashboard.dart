import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({Key? key}) : super(key: key);

  @override
  _SellerDashboardState createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  int _selectedIndex = 0;
  bool _storeIsOpen = true;

  // Mock data
  final Map<String, double> _salesData = {
    'Today': 450.0,
    'This Week': 2850.0,
    'This Month': 12400.0,
  };

  final List<Map<String, dynamic>> _recentOrders = [
    {
      'id': '#ORD1242',
      'time': '25 mins ago',
      'items': 3,
      'total': 78.50,
      'customer': 'John Smith',
      'status': 'Processing',
      'paymentMethod': 'Card',
    },
    {
      'id': '#ORD1241',
      'time': '45 mins ago',
      'items': 2,
      'total': 45.75,
      'customer': 'Emily Johnson',
      'status': 'Completed',
      'paymentMethod': 'Cash',
    },
    {
      'id': '#ORD1240',
      'time': '1 hour ago',
      'items': 1,
      'total': 32.25,
      'customer': 'Michael Brown',
      'status': 'Delivered',
      'paymentMethod': 'Online',
    },
    {
      'id': '#ORD1239',
      'time': '2 hours ago',
      'items': 4,
      'total': 124.50,
      'customer': 'Sarah Wilson',
      'status': 'Completed',
      'paymentMethod': 'Card',
    },
  ];

  final List<Map<String, dynamic>> _popularItems = [
    {
      'name': 'Butter Chicken',
      'price': 18.99,
      'orders': 124,
      'image': 'butter_chicken.jpg',
      'rating': 4.8,
    },
    {
      'name': 'Margherita Pizza',
      'price': 14.50,
      'orders': 98,
      'image': 'margherita.jpg',
      'rating': 4.7,
    },
    {
      'name': 'Fish & Chips',
      'price': 12.75,
      'orders': 87,
      'image': 'fish_chips.jpg',
      'rating': 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenIndex = _selectedIndex;
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: IndexedStack(
        index: screenIndex,
        children: [
          _buildHomeScreen(),
          _buildOrdersScreen(),
          _buildMenuScreen(),
          _buildInsightsScreen(),
          _buildProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.primaryColor,
        selectedItemColor: AppTheme.getAccentColorForUserType(UserType.seller),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_outlined),
            activeIcon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            activeIcon: Icon(Icons.insert_chart),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final accentColor = AppTheme.getAccentColorForUserType(UserType.seller);
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store status bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accentColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.store,
                          color: accentColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'My Restaurant',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _storeIsOpen ? Colors.green : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _storeIsOpen ? 'Open' : 'Closed',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Switch(
                    value: _storeIsOpen,
                    onChanged: (value) {
                      setState(() {
                        _storeIsOpen = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                  ),
                ],
              ),
            ),
            
            // Sales overview cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sales Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSalesCard(
                        'Today',
                        '\$${_salesData['Today']?.toStringAsFixed(2) ?? '0.00'}',
                        Icons.today,
                        accentColor,
                      ),
                      const SizedBox(width: 12),
                      _buildSalesCard(
                        'This Week',
                        '\$${_salesData['This Week']?.toStringAsFixed(2) ?? '0.00'}',
                        Icons.calendar_today,
                        accentColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // New orders section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Orders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;  // Switch to orders tab
                      });
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            ..._recentOrders.map((order) => _buildOrderCard(order, accentColor)),
            
            // Popular items
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _popularItems.length,
                      itemBuilder: (context, index) {
                        final item = _popularItems[index];
                        return _buildPopularItemCard(item, accentColor);
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSalesCard(String title, String value, IconData icon, Color accentColor) {
    return Expanded(
      child: Card(
        color: AppTheme.cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: accentColor, size: 20),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildOrderCard(Map<String, dynamic> order, Color accentColor) {
    final status = order['status'] as String;
    Color statusColor;
    
    switch (status) {
      case 'Processing':
        statusColor = Colors.amber;
        break;
      case 'Delivered':
      case 'Completed':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Order header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      order['id'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      order['time'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Order details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${order['items']} items',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$${order['total'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Customer and payment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order['customer'],
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.payment,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order['paymentMethod'],
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            status == 'Processing' ? Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    onPressed: () {
                      // Reject order
                    },
                    child: const Text('REJECT'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                    ),
                    onPressed: () {
                      // Accept order
                    },
                    child: const Text('ACCEPT'),
                  ),
                ),
              ],
            ) : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                // View order details
              },
              child: const Text('VIEW DETAILS'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPopularItemCard(Map<String, dynamic> item, Color accentColor) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.restaurant,
                  color: accentColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\$${item['price']}',
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${item['rating']} • ${item['orders']} orders',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrdersScreen() {
    return const Center(
      child: Text(
        'Orders Screen',
        style: TextStyle(color: AppTheme.textColor),
      ),
    );
  }

  Widget _buildMenuScreen() {
    return const Center(
      child: Text(
        'Menu Management Screen',
        style: TextStyle(color: AppTheme.textColor),
      ),
    );
  }

  Widget _buildInsightsScreen() {
    return const Center(
      child: Text(
        'Insights & Analytics Screen',
        style: TextStyle(color: AppTheme.textColor),
      ),
    );
  }

  Widget _buildProfileScreen() {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final accentColor = AppTheme.getAccentColorForUserType(UserType.seller);
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      user?.name.substring(0, 1) ?? 'S',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user?.name ?? 'Restaurant Name',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Restaurant Owner',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Menu options
            _buildProfileMenuItem(
              Icons.store_outlined,
              'Restaurant Details',
              'Address, contact, hours, etc.',
              accentColor,
            ),
            
            _buildProfileMenuItem(
              Icons.credit_card_outlined,
              'Payment Methods',
              'Bank accounts, payment details',
              accentColor,
            ),
            
            _buildProfileMenuItem(
              Icons.settings_outlined,
              'Settings',
              'App preferences, notifications',
              accentColor,
            ),
            
            _buildProfileMenuItem(
              Icons.help_outline,
              'Help & Support',
              'FAQs, contact support',
              accentColor,
            ),
            
            _buildProfileMenuItem(
              Icons.policy_outlined,
              'Terms & Policies',
              'Privacy, terms of service',
              accentColor,
            ),
            
            const SizedBox(height: 16),
            
            // Sign out button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  authProvider.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileMenuItem(IconData icon, String title, String subtitle, Color accentColor) {
    return ListTile(
      leading: Icon(icon, color: accentColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: () {
        // Navigate to respective screen
      },
    );
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
} 
 