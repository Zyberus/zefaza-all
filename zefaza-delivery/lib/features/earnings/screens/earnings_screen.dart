import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  // Selected timeframe for analytics
  String _selectedTimeframe = 'Week';
  
  // Mock earnings data
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

  // Mock earnings history
  final List<Map<String, dynamic>> _earningsHistory = [
    {
      'date': '10 July, 2023',
      'deliveries': 6,
      'earnings': 75.0,
      'tips': 12.50,
      'total': 87.50,
    },
    {
      'date': '9 July, 2023',
      'deliveries': 8,
      'earnings': 95.0,
      'tips': 15.0,
      'total': 110.0,
    },
    {
      'date': '8 July, 2023',
      'deliveries': 5,
      'earnings': 65.0,
      'tips': 8.0,
      'total': 73.0,
    },
    {
      'date': '7 July, 2023',
      'deliveries': 7,
      'earnings': 85.0,
      'tips': 10.0,
      'total': 95.0,
    },
    {
      'date': '6 July, 2023',
      'deliveries': 4,
      'earnings': 55.0,
      'tips': 7.5,
      'total': 62.5,
    },
    {
      'date': '5 July, 2023',
      'deliveries': 5,
      'earnings': 60.0,
      'tips': 9.0,
      'total': 69.0,
    },
    {
      'date': '4 July, 2023',
      'deliveries': 3,
      'earnings': 45.0,
      'tips': 6.0,
      'total': 51.0,
    },
  ];

  // Daily earnings chart data for the week
  final List<Map<String, dynamic>> _weeklyEarningsData = [
    {'day': 'Mon', 'earnings': 62.50},
    {'day': 'Tue', 'earnings': 69.0},
    {'day': 'Wed', 'earnings': 51.0},
    {'day': 'Thu', 'earnings': 65.0},
    {'day': 'Fri', 'earnings': 110.0},
    {'day': 'Sat', 'earnings': 73.0},
    {'day': 'Sun', 'earnings': 87.50},
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
              _buildEarningsSummary(),
              _buildEarningsChart(),
              _buildEarningsHistoryHeader(),
              ..._earningsHistory.map((item) => _buildEarningsHistoryItem(item)),
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
            'Earnings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
              letterSpacing: 0.5,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                // Filter earnings
              },
              icon: Icon(
                Icons.filter_list,
                color: AppTheme.accentColor,
              ),
              splashRadius: 24,
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

  Widget _buildEarningsSummary() {
    // Calculate the average earnings per delivery
    final double averageEarning = _earningsData[_selectedTimeframe]! / _deliveriesData[_selectedTimeframe]!;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total Earnings',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${AppConstants.currencySymbol}${_earningsData[_selectedTimeframe]?.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                'Deliveries',
                _deliveriesData[_selectedTimeframe].toString(),
                Icons.motorcycle,
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey[800],
              ),
              _buildSummaryItem(
                'Avg. Per Delivery',
                '${AppConstants.currencySymbol}${averageEarning.toStringAsFixed(2)}',
                Icons.payments_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.grey[400],
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsChart() {
    // Find the max value for scaling
    final maxEarnings = _weeklyEarningsData.map((data) => data['earnings'] as double).reduce(
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
            'Weekly Earnings',
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
              children: _weeklyEarningsData.map((data) {
                final heightPercentage = (data['earnings'] as double) / maxEarnings;
                
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

  Widget _buildEarningsHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Earnings History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          TextButton(
            onPressed: () {
              // View full history
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

  Widget _buildEarningsHistoryItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
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
                        color: AppTheme.accentColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: AppTheme.accentColor,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      item['date'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.motorcycle,
                        color: AppTheme.accentColor,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${item['deliveries']} deliveries',
                        style: TextStyle(
                          color: AppTheme.accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildEarningDetail('Delivery Earnings', item['earnings']),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey[800],
                ),
                Expanded(
                  child: _buildEarningDetail('Tips', item['tips']),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${AppConstants.currencySymbol}${item['total'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentColor,
                      fontSize: 16,
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

  Widget _buildEarningDetail(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${AppConstants.currencySymbol}${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
} 