import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class DeliveriesScreen extends StatefulWidget {
  const DeliveriesScreen({Key? key}) : super(key: key);

  @override
  State<DeliveriesScreen> createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {
  // Selected filter
  String _selectedStatus = 'All';
  
  // Mock deliveries data
  final List<Map<String, dynamic>> _deliveries = [
    {
      'id': '#DEL1242',
      'time': '12:30 PM',
      'customer': 'John Smith',
      'date': '10 July, 2023',
      'distance': '2.3 km',
      'address': '123 Main St, Anytown, USA',
      'status': 'In Transit',
      'payAmount': 15.50,
      'items': 3,
      'customerPhone': '+1 (555) 123-4567',
      'notes': 'Leave at the door please',
    },
    {
      'id': '#DEL1241',
      'time': '11:45 AM',
      'customer': 'Emily Johnson',
      'date': '10 July, 2023',
      'distance': '3.7 km',
      'address': '456 Oak Ave, Somecity, USA',
      'status': 'Delivered',
      'payAmount': 12.75,
      'items': 2,
      'customerPhone': '+1 (555) 987-6543',
      'notes': '',
    },
    {
      'id': '#DEL1240',
      'time': '10:15 AM',
      'customer': 'Michael Brown',
      'date': '10 July, 2023',
      'distance': '1.8 km',
      'address': '789 Pine Rd, Othertown, USA',
      'status': 'Delivered',
      'payAmount': 22.30,
      'items': 4,
      'customerPhone': '+1 (555) 456-7890',
      'notes': 'Call when arriving',
    },
    {
      'id': '#DEL1239',
      'time': '9:30 AM',
      'customer': 'Sarah Davis',
      'date': '10 July, 2023',
      'distance': '4.2 km',
      'address': '101 Maple Dr, Elsewhere, USA',
      'status': 'Delivered',
      'payAmount': 18.90,
      'items': 3,
      'customerPhone': '+1 (555) 789-0123',
      'notes': '',
    },
    {
      'id': '#DEL1238',
      'time': '2:15 PM',
      'customer': 'David Wilson',
      'date': '9 July, 2023',
      'distance': '3.1 km',
      'address': '202 Cedar Ln, Nowhere, USA',
      'status': 'Failed',
      'payAmount': 9.50,
      'items': 1,
      'customerPhone': '+1 (555) 321-6547',
      'notes': 'Apartment 3B',
    },
    {
      'id': '#DEL1237',
      'time': '1:00 PM',
      'customer': 'Jessica Taylor',
      'date': '9 July, 2023',
      'distance': '2.8 km',
      'address': '303 Birch Blvd, Somewhere, USA',
      'status': 'Delivered',
      'payAmount': 14.25,
      'items': 2,
      'customerPhone': '+1 (555) 654-9870',
      'notes': 'Ring doorbell twice',
    },
  ];

  // Get filtered deliveries based on selected status
  List<Map<String, dynamic>> get _filteredDeliveries {
    if (_selectedStatus == 'All') {
      return _deliveries;
    }
    return _deliveries.where((delivery) => delivery['status'] == _selectedStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildFilterChips(),
            Expanded(
              child: _filteredDeliveries.isEmpty 
                ? _buildEmptyState() 
                : _buildDeliveriesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deliveries',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                  letterSpacing: 0.5,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Search functionality
                },
                icon: Icon(
                  Icons.search,
                  color: AppTheme.accentColor,
                  size: 28,
                ),
                splashRadius: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${_filteredDeliveries.length} ${_selectedStatus == "All" ? "Total" : _selectedStatus} Deliveries',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    List<String> statuses = ['All', ...AppConstants.deliveryStatuses];
    
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: statuses.map((status) => _buildFilterChip(status)).toList(),
      ),
    );
  }

  Widget _buildFilterChip(String status) {
    final isSelected = status == _selectedStatus;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status;
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
            status,
            style: TextStyle(
              color: isSelected ? AppTheme.accentColor : Colors.grey[400],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveriesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _filteredDeliveries.length,
      itemBuilder: (context, index) {
        final delivery = _filteredDeliveries[index];
        return _buildDeliveryCard(delivery);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.motorcycle,
              color: AppTheme.accentColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No deliveries found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Deliveries matching your filter will appear here',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 15,
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
        _showDeliveryDetails(context, delivery);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column with icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppTheme.accentColor.withOpacity(0.15)
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isActive ? Icons.motorcycle : Icons.inventory_2_outlined,
                      color: isActive ? AppTheme.accentColor : Colors.grey[400],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Middle column with details
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          delivery['id'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          delivery['customer'],
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.grey[500],
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${delivery['time']} • ${delivery['distance']}',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[500],
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                delivery['address'],
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right column with status and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildStatusBadge(delivery['status']),
                      const SizedBox(height: 8),
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
            // Action row
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
                        // Navigate to delivery location
                      },
                      icon: Icon(
                        Icons.navigation_outlined,
                        size: 16,
                        color: isActive ? AppTheme.accentColor : Colors.grey[400],
                      ),
                      label: Text(
                        'Navigate',
                        style: TextStyle(
                          color: isActive ? AppTheme.accentColor : Colors.grey[400],
                          fontSize: 13,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: isActive ? AppTheme.accentColor : Colors.grey[400],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                          ),
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
                        _showDeliveryDetails(context, delivery);
                      },
                      icon: Icon(
                        Icons.visibility_outlined,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      label: Text(
                        'View Details',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[400],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(16),
                          ),
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
    Color color = _getStatusColor(status);
    
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

  void _showDeliveryDetails(BuildContext context, Map<String, dynamic> delivery) {
    final isActive = delivery['status'] == 'In Transit';
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Delivery header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Details',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[400],
                          ),
                          splashRadius: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          delivery['id'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.accentColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildStatusBadge(delivery['status']),
                      ],
                    ),
                  ],
                ),
              ),
              // Divider
              Container(
                height: 1,
                color: Colors.grey[850],
              ),
              // Delivery details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Map placeholder
                      if (isActive) Container(
                        height: 200,
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.map,
                                color: AppTheme.accentColor,
                                size: 40,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Map View',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildDetailSection(
                        'Customer Information',
                        [
                          _buildDetailRow('Customer', delivery['customer']),
                          _buildDetailRow('Phone', delivery['customerPhone']),
                          if (delivery['notes'].isNotEmpty)
                            _buildDetailRow('Notes', delivery['notes']),
                        ],
                      ),
                      _buildDetailSection(
                        'Delivery Information',
                        [
                          _buildDetailRow('Address', delivery['address']),
                          _buildDetailRow('Distance', delivery['distance']),
                          _buildDetailRow('Scheduled Time', delivery['time']),
                          _buildDetailRow('Items', '${delivery['items']} item${delivery['items'] > 1 ? 's' : ''}'),
                        ],
                      ),
                      _buildDetailSection(
                        'Payment Information',
                        [
                          _buildDetailRow('Delivery Fee', '${AppConstants.currencySymbol}${delivery['payAmount'].toStringAsFixed(2)}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom actions
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isActive ? () {
                          _showUpdateDeliveryStatusDialog(context, delivery);
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          disabledBackgroundColor: Colors.grey[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isActive ? 'Update Status' : 'Completed',
                        ),
                      ),
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Call customer
                          },
                          icon: Icon(
                            Icons.call,
                            color: Colors.grey[400],
                          ),
                          splashRadius: 20,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateDeliveryStatusDialog(BuildContext context, Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppTheme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Update Delivery Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      delivery['id'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.accentColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AppConstants.deliveryStatuses.length,
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: Colors.grey[850],
                        ),
                        itemBuilder: (context, index) {
                          final status = AppConstants.deliveryStatuses[index];
                          final isCurrentStatus = status == delivery['status'];
                          
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            leading: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isCurrentStatus 
                                    ? AppTheme.accentColor
                                    : Colors.grey[800],
                                shape: BoxShape.circle,
                              ),
                              child: isCurrentStatus 
                                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                            title: Text(
                              status,
                              style: TextStyle(
                                color: isCurrentStatus 
                                    ? AppTheme.accentColor
                                    : AppTheme.textColor,
                                fontWeight: isCurrentStatus 
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: isCurrentStatus
                                ? null
                                : () {
                                    Navigator.pop(context);
                                    setState(() {
                                      delivery['status'] = status;
                                    });
                                    // Show snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Delivery status updated to $status'),
                                        backgroundColor: _getStatusColor(status),
                                      ),
                                    );
                                  },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[850]!,
                      width: 1,
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'In Transit':
        return Colors.blue;
      case 'Picked Up':
        return Colors.orange;
      case 'Pending':
      case 'Accepted':
        return Colors.amber;
      case 'Failed':
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
} 