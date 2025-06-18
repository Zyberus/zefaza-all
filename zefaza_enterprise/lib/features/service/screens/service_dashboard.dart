import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';

class ServiceDashboard extends StatefulWidget {
  const ServiceDashboard({Key? key}) : super(key: key);

  @override
  _ServiceDashboardState createState() => _ServiceDashboardState();
}

class _ServiceDashboardState extends State<ServiceDashboard> {
  int _selectedIndex = 0;
  bool _isAvailable = true;
  String _selectedFilter = 'All';

  // Mock data
  final Map<String, dynamic> _stats = {
    'todayBookings': 3,
    'todayEarnings': 175.0,
    'thisWeekBookings': 12,
    'thisWeekEarnings': 720.0,
    'rating': 4.8,
    'totalBookings': 156,
  };

  final List<Map<String, dynamic>> _upcomingBookings = [
    {
      'id': '#SRV1242',
      'service': 'Home Cleaning',
      'time': 'Today, 2:30 PM',
      'address': '123 Main St, Apt 4B',
      'duration': '2 hours',
      'amount': 60.0,
      'customer': 'John Smith',
      'status': 'Confirmed',
      'paymentMethod': 'Online',
    },
    {
      'id': '#SRV1243',
      'service': 'Plumbing Repair',
      'time': 'Tomorrow, 10:00 AM',
      'address': '456 Park Ave',
      'duration': '1 hour',
      'amount': 75.0,
      'customer': 'Sarah Johnson',
      'status': 'Pending',
      'paymentMethod': 'Cash',
    },
    {
      'id': '#SRV1244',
      'service': 'Electrical Work',
      'time': 'Tomorrow, 3:00 PM',
      'address': '789 Elm Street',
      'duration': '3 hours',
      'amount': 120.0,
      'customer': 'Michael Brown',
      'status': 'Confirmed',
      'paymentMethod': 'Card',
    },
  ];

  final List<Map<String, dynamic>> _serviceHistory = [
    {
      'id': '#SRV1237',
      'service': 'AC Repair',
      'date': 'June 15, 2023',
      'customer': 'David Wilson',
      'amount': 95.0,
      'status': 'Completed',
    },
    {
      'id': '#SRV1236',
      'service': 'Furniture Assembly',
      'date': 'June 14, 2023',
      'customer': 'Lisa Garcia',
      'amount': 45.0,
      'status': 'Completed',
    },
    {
      'id': '#SRV1235',
      'service': 'Plumbing',
      'date': 'June 12, 2023',
      'customer': 'Robert Taylor',
      'amount': 65.0,
      'status': 'Cancelled',
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
          _buildBookingsScreen(),
          _buildServicesScreen(),
          _buildEarningsScreen(),
          _buildProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.primaryColor,
        selectedItemColor: AppTheme.getAccentColorForUserType(UserType.service),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_outlined),
            activeIcon: Icon(Icons.handyman),
            label: 'Services',
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

  Widget _buildHomeScreen() {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final accentColor = AppTheme.getAccentColorForUserType(UserType.service);
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Availability status bar
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
                        child: Text(
                          user?.name.substring(0, 1) ?? 'S',
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
                            'Hello, ${user?.name.split(' ')[0] ?? 'Provider'}',
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
                                  color: _isAvailable ? Colors.green : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _isAvailable ? 'Available' : 'Unavailable',
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
                    value: _isAvailable,
                    onChanged: (value) {
                      setState(() {
                        _isAvailable = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                  ),
                ],
              ),
            ),
            
            // Stats overview
            Container(
              padding: const EdgeInsets.all(16),
              color: AppTheme.cardColor.withOpacity(0.5),
              child: Column(
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatCard(
                        'Today\'s Bookings',
                        '${_stats['todayBookings']}',
                        Icons.calendar_today,
                        accentColor,
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        'Today\'s Earnings',
                        '\$${_stats['todayEarnings']}',
                        Icons.payments_outlined,
                        accentColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatCard(
                        'Rating',
                        '${_stats['rating']} ★',
                        Icons.star,
                        Colors.amber,
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        'Total Jobs',
                        '${_stats['totalBookings']}',
                        Icons.handyman,
                        accentColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Upcoming bookings header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Bookings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1; // Switch to bookings tab
                      });
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Filter chips
            SizedBox(
              height: 50,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('All', accentColor),
                  _buildFilterChip('Confirmed', accentColor),
                  _buildFilterChip('Pending', accentColor),
                  _buildFilterChip('Today', accentColor),
                  _buildFilterChip('Tomorrow', accentColor),
                ],
              ),
            ),
            
            // Upcoming bookings list
            ..._upcomingBookings.map((booking) => _buildBookingCard(booking, accentColor)),
            
            // Recent history header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Recent history list
            ..._serviceHistory.map((service) => _buildHistoryCard(service, accentColor)),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color accentColor) {
    final isSelected = _selectedFilter == label;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? accentColor : AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? accentColor : Colors.grey.shade700,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade400,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
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
    );
  }
  
  Widget _buildBookingCard(Map<String, dynamic> booking, Color accentColor) {
    final isConfirmed = booking['status'] == 'Confirmed';
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getServiceIcon(booking['service']),
                        color: accentColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['service'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                          ),
                        ),
                        Text(
                          booking['time'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isConfirmed ? Colors.green.withOpacity(0.2) : Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isConfirmed ? Colors.green : Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            
            // Info rows
            _buildInfoRow(Icons.location_on_outlined, booking['address']),
            _buildInfoRow(Icons.schedule, '${booking['duration']} • \$${booking['amount']}'),
            _buildInfoRow(Icons.person_outline, booking['customer']),
            
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor),
                    ),
                    onPressed: () {
                      // Call client
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('CALL'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                    ),
                    onPressed: () {
                      // Navigate to booking
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('NAVIGATE'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHistoryCard(Map<String, dynamic> service, Color accentColor) {
    final isCompleted = service['status'] == 'Completed';
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCompleted 
              ? Colors.green.withOpacity(0.2)
              : Colors.red.withOpacity(0.2),
          child: Icon(
            isCompleted ? Icons.check : Icons.close,
            color: isCompleted ? Colors.green : Colors.red,
            size: 20,
          ),
        ),
        title: Text(
          service['service'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        subtitle: Text(
          '${service['date']} • ${service['customer']}',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
        trailing: Text(
          '\$${service['amount']}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        onTap: () {
          // View service details
        },
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getServiceIcon(String service) {
    switch (service.toLowerCase()) {
      case 'home cleaning':
        return Icons.cleaning_services;
      case 'plumbing repair':
      case 'plumbing':
        return Icons.plumbing;
      case 'electrical work':
        return Icons.electrical_services;
      case 'ac repair':
        return Icons.ac_unit;
      case 'furniture assembly':
        return Icons.chair;
      default:
        return Icons.handyman;
    }
  }

  Widget _buildBookingsScreen() {
    return const Center(
      child: Text(
        'All Bookings Screen',
        style: TextStyle(color: AppTheme.textColor),
      ),
    );
  }

  Widget _buildServicesScreen() {
    return const Center(
      child: Text(
        'Service Management Screen',
        style: TextStyle(color: AppTheme.textColor),
      ),
    );
  }

  Widget _buildEarningsScreen() {
    return const Center(
      child: Text(
        'Earnings Screen',
        style: TextStyle(color: AppTheme.textColor),
      ),
    );
  }

  Widget _buildProfileScreen() {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final accentColor = AppTheme.getAccentColorForUserType(UserType.service);
    
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
                    user?.name ?? 'Service Provider',
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
                      SizedBox(width: 4),
                      Text(
                        '(156 jobs)',
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
            
            // Profile menu items
            _buildProfileMenuItem(
              Icons.account_circle_outlined,
              'Personal Information',
              'Update profile, ID verification, etc.',
              accentColor,
            ),
            
            _buildProfileMenuItem(
              Icons.workspace_premium_outlined,
              'Professional Details',
              'Skills, certifications, experience',
              accentColor,
            ),
            
            _buildProfileMenuItem(
              Icons.credit_card_outlined,
              'Payment Details',
              'Bank accounts, payment methods',
              accentColor,
            ),
            
            _buildProfileMenuItem(
              Icons.photo_outlined,
              'Portfolio',
              'Photos of your work',
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