import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/screens/login_screen.dart';
import '../../bookings/screens/service_details_screen.dart';
import '../widgets/edit_profile_modal.dart';
import '../widgets/help_support_modal.dart';
import '../widgets/all_services_modal.dart';
import '../widgets/notification_settings_modal.dart';
import '../widgets/language_settings_modal.dart';

class SimpleDashboardScreen extends StatefulWidget {
  const SimpleDashboardScreen({Key? key}) : super(key: key);

  @override
  State<SimpleDashboardScreen> createState() => _SimpleDashboardScreenState();
}

class _SimpleDashboardScreenState extends State<SimpleDashboardScreen> {
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Michael Rodriguez',
    'rating': 4.8,
    'availableStatus': true,
    'earnings': {
      'today': 95.0,
      'total': 2350.0,
    },
    'services': {
      'completed': 48,
      'pending': 2,
    },
    'settings': {
      'theme': 'dark',
      'language': 'en',
      'notificationSettings': {
        'service_requests': true,
        'service_reminders': true,
        'payment_updates': true,
        'app_updates': true,
        'marketing': false,
      },
      'privacySettings': {
        'location_sharing': true,
        'profile_visibility': true,
        'data_collection': false,
        'activity_status': true,
      },
    },
  };

  // Mock upcoming service requests
  final List<Map<String, dynamic>> _upcomingServices = [
    {
      'id': '#SVC1001',
      'type': 'Cleaning',
      'time': '12:30 PM',
      'address': '123 Main St, Anytown, USA',
      'status': 'Pending',
      'payAmount': 55.00,
    },
    {
      'id': '#SVC1002',
      'type': 'Cooking',
      'time': '4:00 PM',
      'address': '456 Oak Ave, Somecity, USA',
      'status': 'Accepted',
      'payAmount': 75.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildQuickStats(),
              _buildServiceRequestsHeader(),
              ..._upcomingServices.map((service) => _buildServiceCard(service)),
              _buildProfileSection(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${_userData['name'].split(' ')[0]}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _userData['availableStatus'] ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _userData['availableStatus'] ? 'Available' : 'Not Available',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: _showProfileOptions,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.accentColor,
              child: Text(
                _userData['name'].toString().substring(0, 1),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Today\'s Earnings',
                  '${AppConstants.currencySymbol}${_userData['earnings']['today'].toStringAsFixed(2)}',
                  Icons.account_balance_wallet,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Total Earnings',
                  '${AppConstants.currencySymbol}${_userData['earnings']['total'].toStringAsFixed(2)}',
                  Icons.trending_up,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Pending Services',
                  '${_userData['services']['pending']}',
                  Icons.pending_actions,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Rating',
                  '${_userData['rating']}',
                  Icons.star,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.accentColor),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRequestsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Upcoming Services',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          TextButton(
            onPressed: () {
              _showAllServices();
            },
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    Color statusColor = service['status'] == 'Pending' 
        ? Colors.orange 
        : service['status'] == 'Accepted' 
        ? Colors.blue 
        : Colors.green;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service['id'],
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    service['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  service['type'],
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  service['time'],
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        service['address'],
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${AppConstants.currencySymbol}${service['payAmount'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[800], height: 1),
          Row(
            children: [
              if (service['status'] == 'Pending')
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _showServiceDetails(service);
                    },
                    child: const Text(
                      'Reject',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              if (service['status'] == 'Pending')
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showServiceDetails(service);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('Accept'),
                  ),
                )
              else
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle view details
                      _showServiceDetails(service);
                    },
                    child: const Text('View Details'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Available for Work',
              style: TextStyle(color: AppTheme.textColor),
            ),
            subtitle: Text(
              'Toggle to show your availability status',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            value: _userData['availableStatus'],
            onChanged: (value) {
              setState(() {
                _userData['availableStatus'] = value;
              });
            },
            activeColor: AppTheme.accentColor,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _showAccountSettings,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: const Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text('Account Settings'),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProfileOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.account_circle, color: AppTheme.accentColor),
              title: const Text('Edit Profile', style: TextStyle(color: AppTheme.textColor)),
              onTap: () {
                Navigator.pop(context);
                _showEditProfile();
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: AppTheme.accentColor),
              title: const Text('Help & Support', style: TextStyle(color: AppTheme.textColor)),
              onTap: () {
                Navigator.pop(context);
                _showHelpAndSupport();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAllServices() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AllServicesModal(services: _upcomingServices),
    );
  }

  void _showServiceDetails(Map<String, dynamic> service) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceDetailsScreen(service: service),
      ),
    ).then((result) {
      if (result != null && result is Map<String, dynamic> && result.containsKey('status')) {
        // Update local status if returned from service details screen
        setState(() {
          int index = _upcomingServices.indexWhere((s) => s['id'] == service['id']);
          if (index != -1) {
            _upcomingServices[index]['status'] = result['status'];
          }
        });
      }
    });
  }

  void _showAccountSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAccountSettingsModal(),
    );
  }

  Widget _buildAccountSettingsModal() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Icon(
                Icons.settings,
                color: AppTheme.accentColor,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSettingsItem('Notification Settings', Icons.notifications, () {
            Navigator.pop(context);
            _showNotificationSettings();
          }),
          _buildSettingsItem('Language', Icons.language, () {
            Navigator.pop(context);
            _showLanguageSettings();
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.accentColor),
      title: Text(title, style: const TextStyle(color: AppTheme.textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
  
  void _showEditProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: EditProfileModal(
          userData: _userData,
          onUpdate: (updatedData) {
            setState(() {
              _userData.addAll(updatedData);
            });
          },
        ),
      ),
    );
  }
  
  void _showHelpAndSupport() {
    showDialog(
      context: context,
      builder: (context) => const HelpSupportModal(),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        title: const Text(
          'Logout',
          style: TextStyle(color: AppTheme.textColor),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform logout
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    // Get notification settings from userData or use defaults
    Map<String, bool> notificationSettings = _userData['settings']['notificationSettings'] ?? {};
    
    showDialog(
      context: context,
      builder: (context) => NotificationSettingsModal(
        notificationSettings: notificationSettings,
        onUpdate: (updatedSettings) {
          setState(() {
            _userData['settings']['notificationSettings'] = updatedSettings;
          });
        },
      ),
    );
  }
  
  void _showLanguageSettings() {
    // Get current language setting from userData or use default
    String currentLanguage = _userData['settings']['language'] ?? 'en';
    
    showDialog(
      context: context,
      builder: (context) => LanguageSettingsModal(
        currentLanguage: currentLanguage,
        onUpdate: (selectedLanguage) {
          setState(() {
            _userData['settings']['language'] = selectedLanguage;
          });
        },
      ),
    );
  }
  

} 