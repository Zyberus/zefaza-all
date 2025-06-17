import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Selected timeframe for analytics
  String _selectedTimeframe = 'Week';

  // Mock data for demonstration
  final Map<String, double> _earningsData = {
    'Today': 75.0,
    'Week': 485.0,
    'Month': 1950.0,
    'Year': 23500.0,
  };
  
  final Map<String, int> _deliveriesData = {
    'Today': 6,
    'Week': 42,
    'Month': 168,
    'Year': 2040,
  };

  // Mock chart data for weekly deliveries
  final List<Map<String, dynamic>> _chartData = [
    {'day': 'Mon', 'deliveries': 5},
    {'day': 'Tue', 'deliveries': 7},
    {'day': 'Wed', 'deliveries': 8},
    {'day': 'Thu', 'deliveries': 6},
    {'day': 'Fri', 'deliveries': 9},
    {'day': 'Sat', 'deliveries': 10},
    {'day': 'Sun', 'deliveries': 4},
  ];

  // Mock current/upcoming deliveries
  final List<Map<String, dynamic>> _activeDeliveries = [
    {
      'id': '#DEL1242',
      'time': '12:30 PM',
      'distance': '2.3 km',
      'address': '123 Main St, Anytown, USA',
      'status': 'In Transit',
      'payAmount': 15.50,
    },
    {
      'id': '#DEL1243',
      'time': '1:15 PM',
      'distance': '3.7 km',
      'address': '456 Oak Ave, Somecity, USA',
      'status': 'Pending',
      'payAmount': 12.75,
    },
    {
      'id': '#DEL1244',
      'time': '2:00 PM',
      'distance': '1.8 km',
      'address': '789 Pine Rd, Othertown, USA',
      'status': 'Pending',
      'payAmount': 10.25,
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
              _buildTimeframeSelector(),
              _buildMetricsCards(),
              _buildWeeklyChart(),
              _buildActiveDeliveriesHeader(),
              ..._activeDeliveries.map((delivery) => _buildDeliveryCard(delivery)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentColor,
        onPressed: () {
          // Action to toggle availability status
          _toggleAvailabilityStatus(context);
        },
        child: const Icon(
          Icons.power_settings_new,
          color: Colors.white,
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
                'Dashboard',
                style: TextStyle(
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
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.accentColor,
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.timeframes.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final timeframe = AppConstants.timeframes[index];
          final isSelected = timeframe == _selectedTimeframe;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeframe = timeframe;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.accentColor.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppTheme.accentColor : Colors.grey[800]!,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  timeframe,
                  style: TextStyle(
                    color: isSelected ? AppTheme.accentColor : Colors.grey[400],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildMetricCard(
            'Total Earnings',
            '${AppConstants.currencySymbol}${_earningsData[_selectedTimeframe]?.toStringAsFixed(2)}',
            Icons.account_balance_wallet,
          ),
          const SizedBox(width: 16),
          _buildMetricCard(
            'Deliveries',
            '${_deliveriesData[_selectedTimeframe]}',
            Icons.motorcycle,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
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
      ),
    );
  }

  Widget _buildWeeklyChart() {
    // Find the max value for scaling
    final maxDeliveries = _chartData.map((data) => data['deliveries'] as int).reduce(
      (value, element) => value > element ? value : element,
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _chartData.map((data) {
                final heightPercentage = (data['deliveries'] as int) / maxDeliveries;
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30,
                      height: 120 * heightPercentage,
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['day'],
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDeliveriesHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today\'s Deliveries',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          TextButton(
            onPressed: () {
              // View all deliveries
            },
            child: Text(
              'View All',
              style: TextStyle(
                color: AppTheme.accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    final isActive = delivery['status'] == 'In Transit';
    
    return GestureDetector(
      onTap: () {
        // Show delivery details
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: isActive
              ? Border.all(color: AppTheme.accentColor, width: 1)
              : null,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.accentColor.withOpacity(0.15)
                                  : Colors.grey[800],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isActive ? Icons.motorcycle : Icons.access_time,
                              color: isActive ? AppTheme.accentColor : Colors.grey[400],
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                delivery['id'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey[500],
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    delivery['time'],
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      _buildStatusBadge(delivery['status']),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[500],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          delivery['address'],
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.straight,
                            color: Colors.grey[500],
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            delivery['distance'],
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${AppConstants.currencySymbol}${delivery['payAmount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Action buttons
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        // Navigate to delivery
                      },
                      icon: const Icon(
                        Icons.navigation_outlined,
                        size: 16,
                      ),
                      label: const Text(
                        'Navigate',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey[800],
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        // View delivery details
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        size: 16,
                      ),
                      label: const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    
    switch (status) {
      case 'In Transit':
        color = Colors.blue;
        break;
      case 'Pending':
        color = Colors.amber;
        break;
      case 'Delivered':
        color = Colors.green;
        break;
      case 'Failed':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleAvailabilityStatus(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Change Status',
          style: TextStyle(
            color: AppTheme.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to go offline? You won\'t receive new delivery requests.',
          style: TextStyle(
            color: AppTheme.textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              // Change availability status
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
            ),
            child: const Text('GO OFFLINE'),
          ),
        ],
      ),
    );
  }
} 