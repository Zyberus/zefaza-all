import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/providers/auth_provider.dart';

class DeliveryDashboard extends StatefulWidget {
  const DeliveryDashboard({Key? key}) : super(key: key);

  @override
  State<DeliveryDashboard> createState() => _DeliveryDashboardState();
}

class _DeliveryDashboardState extends State<DeliveryDashboard> {
  int _selectedIndex = 0;
  bool _isOnline = true;
  
  // Dashboard content
  late List<Widget> _screens;
  late Widget _dashboardContentWidget;
  late Widget _deliveriesContentWidget;
  late Widget _earningsContentWidget;
  late Widget _profileContentWidget;

  // Mock data for demonstration
  final Map<String, double> _earningsData = {
    'Today': 75.0,
    'This Week': 485.0,
  };
  
  final List<Map<String, dynamic>> _activeDeliveries = [
    {
      'id': '#DEL1242',
      'restaurant': 'Pizza Palace',
      'time': '12:30 PM',
      'distance': '2.3 km',
      'address': '123 Main St, Anytown',
      'status': 'Ready for pickup',
      'payAmount': 15.50,
      'items': 2,
      'customerName': 'John Smith',
    },
    {
      'id': '#DEL1243',
      'restaurant': 'Burger Barn',
      'time': '1:15 PM',
      'distance': '3.7 km',
      'address': '456 Oak Ave, Somecity',
      'status': 'Pending',
      'payAmount': 12.75,
      'items': 1,
      'customerName': 'Sarah Johnson',
    },
    {
      'id': '#DEL1244',
      'restaurant': 'Taco Town',
      'time': '2:00 PM',
      'distance': '1.8 km',
      'address': '789 Pine Rd, Othertown',
      'status': 'Pending',
      'payAmount': 10.25,
      'items': 4,
      'customerName': 'Mike Brown',
    },
  ];

  // Recent completed deliveries
  final List<Map<String, dynamic>> _recentDeliveries = [
    {
      'id': '#DEL1241',
      'restaurant': 'Sushi Spot',
      'time': 'Today, 11:45 AM',
      'distance': '4.2 km',
      'payAmount': 18.50,
    },
    {
      'id': '#DEL1240',
      'restaurant': 'Pasta Place',
      'time': 'Today, 10:30 AM',
      'distance': '2.8 km',
      'payAmount': 14.25,
    },
    {
      'id': '#DEL1239',
      'restaurant': 'Noodle House',
      'time': 'Yesterday, 7:15 PM',
      'distance': '3.5 km',
      'payAmount': 16.75,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize screens but don't access Provider here
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to use Provider here
    _dashboardContentWidget = _buildDashboardContent();
    _deliveriesContentWidget = _buildDeliveriesContent();
    _earningsContentWidget = _buildEarningsContent();
    _profileContentWidget = _buildProfileContent();
    
    _screens = [
      _dashboardContentWidget,
      _deliveriesContentWidget,
      _earningsContentWidget,
      _profileContentWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.primaryColor,
        selectedItemColor: AppTheme.getAccentColorForUserType(UserType.delivery),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining_outlined),
            activeIcon: Icon(Icons.delivery_dining),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Earnings',
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

  // Dashboard tab content
  Widget _buildDashboardContent() {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final accentColor = AppTheme.getAccentColorForUserType(UserType.delivery);
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with online toggle
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
                        child: Text(
                          user?.name.substring(0, 1) ?? 'D',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${user?.name.split(' ')[0] ?? 'Rider'}',
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
                                  color: _isOnline ? Colors.green : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _isOnline ? 'Online' : 'Offline',
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
                    value: _isOnline,
                    onChanged: (value) {
                      setState(() {
                        _isOnline = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                  ),
                ],
              ),
            ),
            
            // Quick stats cards
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildQuickStatCard(
                    'Today\'s Earnings',
                    '${AppConstants.currencySymbol}${_earningsData['Today']?.toStringAsFixed(2)}',
                    Icons.attach_money,
                    accentColor,
                  ),
                  const SizedBox(width: 12),
                  _buildQuickStatCard(
                    'This Week',
                    '${AppConstants.currencySymbol}${_earningsData['This Week']?.toStringAsFixed(2)}',
                    Icons.calendar_today,
                    accentColor,
                  ),
                ],
              ),
            ),
            
            // Delivery opportunities header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Delivery Opportunities',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  Text(
                    '${_activeDeliveries.length} available',
                    style: TextStyle(
                      fontSize: 14,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Active deliveries
            ..._activeDeliveries.map((delivery) => _buildDeliveryOpportunityCard(delivery, accentColor)),
            
            // Recent deliveries header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: const Text(
                'Recent Deliveries',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ),
            
            // Recent deliveries
            ..._recentDeliveries.map((delivery) => _buildRecentDeliveryCard(delivery)),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  // Deliveries tab content
  Widget _buildDeliveriesContent() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'My Deliveries',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: AppTheme.textColor),
                  onPressed: () {
                    // Filter deliveries
                  },
                ),
              ],
            ),
          ),
          
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelColor: AppTheme.getAccentColorForUserType(UserType.delivery),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppTheme.getAccentColorForUserType(UserType.delivery),
                    tabs: const [
                      Tab(text: 'TODAY'),
                      Tab(text: 'THIS WEEK'),
                      Tab(text: 'ALL'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildDeliveriesList(_recentDeliveries),
                        _buildDeliveriesList([..._recentDeliveries, ..._recentDeliveries]),
                        _buildDeliveriesList([..._recentDeliveries, ..._recentDeliveries, ..._recentDeliveries]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Earnings tab content
  Widget _buildEarningsContent() {
    final accentColor = AppTheme.getAccentColorForUserType(UserType.delivery);
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: accentColor,
              ),
              child: Column(
                children: const [
                  Text(
                    'Total Earnings',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${AppConstants.currencySymbol}2,350.75',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: AppTheme.cardColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Earnings Breakdown',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildEarningItem('This Week', '${AppConstants.currencySymbol}485.00', accentColor),
                      _buildEarningItem('This Month', '${AppConstants.currencySymbol}1,950.00', accentColor),
                      _buildEarningItem('Last Month', '${AppConstants.currencySymbol}1,850.00', accentColor),
                    ],
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: AppTheme.cardColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Performance Stats',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPerformanceStat('On-time Deliveries', '95%', accentColor),
                      _buildPerformanceStat('Customer Rating', '4.8/5.0', accentColor),
                      _buildPerformanceStat('Acceptance Rate', '92%', accentColor),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  // Profile tab content
  Widget _buildProfileContent() {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final accentColor = AppTheme.getAccentColorForUserType(UserType.delivery);
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
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
                      user?.name.substring(0, 1) ?? 'D',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user?.name ?? 'Delivery Partner',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '(142 Deliveries)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            _buildProfileListTile(
              Icons.account_circle_outlined,
              'Account Details',
              'Personal information, ID, etc.',
              accentColor,
            ),
            
            _buildProfileListTile(
              Icons.two_wheeler_outlined,
              'Vehicle Information',
              'Registration, documents, etc.',
              accentColor,
            ),
            
            _buildProfileListTile(
              Icons.payments_outlined,
              'Payment Details',
              'Bank account, payment methods',
              accentColor,
            ),
            
            _buildProfileListTile(
              Icons.settings_outlined,
              'App Settings',
              'Notifications, language, etc.',
              accentColor,
            ),
            
            _buildProfileListTile(
              Icons.help_outline,
              'Help & Support',
              'FAQ, contact support',
              accentColor,
            ),
            
            const SizedBox(height: 16),
            
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
                  'LOG OUT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileListTile(IconData icon, String title, String subtitle, Color accentColor) {
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
        // Handle navigation
      },
    );
  }

  Widget _buildEarningItem(String period, String amount, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            period,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textColor,
            ),
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPerformanceStat(String title, String value, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textColor,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDeliveriesList(List<Map<String, dynamic>> deliveries) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: deliveries.length,
      itemBuilder: (context, index) {
        final delivery = deliveries[index];
        return _buildRecentDeliveryCard(delivery);
      },
    );
  }
  
  Widget _buildQuickStatCard(String title, String value, IconData icon, Color accentColor) {
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

  Widget _buildDeliveryOpportunityCard(Map<String, dynamic> delivery, Color accentColor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Restaurant info
          ListTile(
            leading: CircleAvatar(
              backgroundColor: accentColor.withOpacity(0.2),
              child: Icon(
                Icons.restaurant,
                color: accentColor,
                size: 20,
              ),
            ),
            title: Text(
              delivery['restaurant'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            subtitle: Text(
              '${delivery['distance']} • ${delivery['time']}',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${AppConstants.currencySymbol}${delivery['payAmount']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: accentColor,
                  ),
                ),
                Text(
                  '${delivery['items']} items',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Customer and address info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        delivery['customerName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        delivery['address'],
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Accept order
                    },
                    child: const Text('ACCEPT'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDeliveryCard(Map<String, dynamic> delivery) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.2),
          child: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
        ),
        title: Text(
          delivery['restaurant'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        subtitle: Text(
          '${delivery['distance']} • ${delivery['time']}',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
        trailing: Text(
          '${AppConstants.currencySymbol}${delivery['payAmount']}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        onTap: () {
          // Show delivery details
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
} 