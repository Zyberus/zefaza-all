import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Selected filter
  String _selectedStatus = 'All';
  
  // Mock orders data
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#ORD1242',
      'customer': 'John Smith',
      'date': '10 July, 2023',
      'amount': 123.45,
      'status': 'Delivered',
      'items': 3,
      'paymentMethod': 'Credit Card',
      'address': '123 Main St, Anytown, USA',
    },
    {
      'id': '#ORD1241',
      'customer': 'Emily Johnson',
      'date': '9 July, 2023',
      'amount': 78.25,
      'status': 'Shipped',
      'items': 1,
      'paymentMethod': 'PayPal',
      'address': '456 Oak Ave, Somecity, USA',
    },
    {
      'id': '#ORD1240',
      'customer': 'Michael Brown',
      'date': '8 July, 2023',
      'amount': 245.99,
      'status': 'Processing',
      'items': 4,
      'paymentMethod': 'Credit Card',
      'address': '789 Pine Rd, Othertown, USA',
    },
    {
      'id': '#ORD1239',
      'customer': 'Sarah Davis',
      'date': '7 July, 2023',
      'amount': 49.99,
      'status': 'Delivered',
      'items': 1,
      'paymentMethod': 'Debit Card',
      'address': '101 Maple Dr, Elsewhere, USA',
    },
    {
      'id': '#ORD1238',
      'customer': 'David Wilson',
      'date': '6 July, 2023',
      'amount': 189.50,
      'status': 'Cancelled',
      'items': 2,
      'paymentMethod': 'Credit Card',
      'address': '202 Cedar Ln, Nowhere, USA',
    },
    {
      'id': '#ORD1237',
      'customer': 'Jessica Taylor',
      'date': '5 July, 2023',
      'amount': 135.75,
      'status': 'Pending',
      'items': 3,
      'paymentMethod': 'PayPal',
      'address': '303 Birch Blvd, Somewhere, USA',
    },
  ];

  // Get filtered orders based on selected status
  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedStatus == 'All') {
      return _orders;
    }
    return _orders.where((order) => order['status'] == _selectedStatus).toList();
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
              child: _filteredOrders.isEmpty 
                ? _buildEmptyState() 
                : _buildOrdersList(),
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
                'Orders',
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
            '${_filteredOrders.length} ${_selectedStatus == "All" ? "Total" : _selectedStatus} Orders',
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
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildFilterChip('All'),
          ...AppConstants.orderStatuses.map((status) => _buildFilterChip(status)),
        ],
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

  Widget _buildOrdersList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        final order = _filteredOrders[index];
        return _buildOrderCard(order);
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
              Icons.receipt_long,
              color: AppTheme.accentColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No orders found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Orders matching your filter will appear here',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () {
        _showOrderDetails(context, order);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID and Date column
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['id'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order['customer'],
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey[500],
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              order['date'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Amount and Status column
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${AppConstants.currencySymbol}${order['amount'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildStatusBadge(order['status']),
                        const SizedBox(height: 8),
                        Text(
                          '${order['items']} item${order['items'] > 1 ? 's' : ''}',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Action row
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        _showUpdateStatusDialog(context, order);
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 16,
                        color: AppTheme.accentColor,
                      ),
                      label: Text(
                        'Update Status',
                        style: TextStyle(
                          color: AppTheme.accentColor,
                          fontSize: 13,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.accentColor,
                        shape: RoundedRectangleBorder(
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
                        // View order details
                        _showOrderDetails(context, order);
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
                        shape: RoundedRectangleBorder(
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
    final color = _getStatusColor(status);
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

  void _showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.only(
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
              // Order header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Details',
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
                          order['id'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.accentColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildStatusBadge(order['status']),
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
              // Order details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailSection(
                        'Customer Information',
                        [
                          _buildDetailRow('Customer', order['customer']),
                          _buildDetailRow('Order Date', order['date']),
                          _buildDetailRow('Payment Method', order['paymentMethod']),
                        ],
                      ),
                      _buildDetailSection(
                        'Shipping Address',
                        [
                          _buildDetailRow('Address', order['address']),
                        ],
                      ),
                      _buildDetailSection(
                        'Order Summary',
                        [
                          _buildDetailRow('Items', '${order['items']} item${order['items'] > 1 ? 's' : ''}'),
                          _buildDetailRow('Total', '${AppConstants.currencySymbol}${order['amount'].toStringAsFixed(2)}'),
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
                        onPressed: () {
                          Navigator.pop(context);
                          _showUpdateStatusDialog(context, order);
                        },
                        child: Text('Update Status'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Print order
                        },
                        icon: Icon(
                          Icons.print_outlined,
                          color: Colors.grey[400],
                        ),
                        splashRadius: 20,
                      ),
                    ),
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

  void _showUpdateStatusDialog(BuildContext context, Map<String, dynamic> order) {
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
                      'Update Order Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order['id'],
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
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: AppConstants.orderStatuses.length,
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: Colors.grey[850],
                        ),
                        itemBuilder: (context, index) {
                          final status = AppConstants.orderStatuses[index];
                          final isCurrentStatus = status == order['status'];
                          
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
                                  ? Icon(Icons.check, size: 16, color: Colors.black)
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
                                      order['status'] = status;
                                    });
                                    // Show snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Order status updated to $status'),
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
                    shape: RoundedRectangleBorder(
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
      case 'Shipped':
        return Colors.blue;
      case 'Processing':
        return Colors.orange;
      case 'Pending':
        return Colors.amber;
      case 'Cancelled':
        return Colors.red;
      case 'Returned':
        return Colors.purple;
      case 'Refunded':
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }
} 