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
  final Map<String, double> _salesData = {
    'Today': 450.0,
    'Week': 2850.0,
    'Month': 12400.0,
    'Year': 149000.0,
  };
  
  final Map<String, int> _ordersData = {
    'Today': 3,
    'Week': 24,
    'Month': 98,
    'Year': 1200,
  };

  // Mock chart data
  final List<Map<String, dynamic>> _chartData = [
    {'day': 'Mon', 'sales': 400.0},
    {'day': 'Tue', 'sales': 350.0},
    {'day': 'Wed', 'sales': 500.0},
    {'day': 'Thu', 'sales': 450.0},
    {'day': 'Fri', 'sales': 700.0},
    {'day': 'Sat', 'sales': 600.0},
    {'day': 'Sun', 'sales': 350.0},
  ];

  // Mock recent orders
  final List<Map<String, dynamic>> _recentOrders = [
    {
      'id': '#1242',
      'date': '10 July, 2023',
      'amount': 123.45,
      'status': 'Delivered',
      'items': 3,
    },
    {
      'id': '#1241',
      'date': '9 July, 2023',
      'amount': 78.25,
      'status': 'Shipped',
      'items': 1,
    },
    {
      'id': '#1240',
      'date': '8 July, 2023',
      'amount': 245.99,
      'status': 'Processing',
      'items': 4,
    },
    {
      'id': '#1239',
      'date': '7 July, 2023',
      'amount': 49.99,
      'status': 'Delivered',
      'items': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildTimeframeSelector(),
              _buildMetricsCards(),
              _buildSalesChart(),
              _buildRecentOrdersHeader(),
              ..._recentOrders.map((order) => _buildOrderCard(order)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Welcome back, Seller',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.accentColor,
            child: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.timeframes.length,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          final timeframe = AppConstants.timeframes[index];
          final isSelected = timeframe == _selectedTimeframe;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeframe = timeframe;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.accentColor : AppTheme.cardColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  timeframe,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          _buildMetricCard(
            'Total Sales',
            '${AppConstants.currencySymbol}${_salesData[_selectedTimeframe]?.toStringAsFixed(2)}',
            Icons.attach_money,
            Colors.green,
          ),
          const SizedBox(width: 15),
          _buildMetricCard(
            'Orders',
            '${_ordersData[_selectedTimeframe]}',
            Icons.shopping_bag,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesChart() {
    // Find the max value for scaling
    final maxSales = _chartData.map((data) => data['sales'] as double).reduce(
      (value, element) => value > element ? value : element,
    );

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
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
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _chartData.map((data) {
                final barHeight = (data['sales'] as double) / maxSales * 150;
                
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: barHeight,
                        width: 20,
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['day'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrdersHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Recent Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to orders screen
            },
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    // Set color based on status
    Color statusColor;
    switch (order['status']) {
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Shipped':
        statusColor = Colors.blue;
        break;
      case 'Processing':
        statusColor = Colors.orange;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.shopping_bag_outlined,
                color: AppTheme.accentColor,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['id'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    Text(
                      '${AppConstants.currencySymbol}${order['amount'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${order['items']} item${order['items'] > 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  order['date'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 