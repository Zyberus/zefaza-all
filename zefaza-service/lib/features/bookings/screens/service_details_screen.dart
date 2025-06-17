import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> service;

  const ServiceDetailsScreen({Key? key, required this.service}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  bool _isLoading = false;
  String _serviceStatus = '';
  
  @override
  void initState() {
    super.initState();
    _serviceStatus = widget.service['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          '${widget.service['type']} Service',
          style: const TextStyle(
            color: AppTheme.textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServiceDetailsCard(),
            _buildLocationSection(),
            _buildClientSection(),
            _buildActionButtons(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDetailsCard() {
    // Get status color
    Color statusColor = _serviceStatus == 'Pending'
        ? Colors.orange
        : _serviceStatus == 'Accepted'
            ? Colors.blue
            : _serviceStatus == 'In Progress'
                ? Colors.purple
                : _serviceStatus == 'Completed'
                    ? Colors.green
                    : Colors.red;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.service['id'],
                style: const TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 18,
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
                  _serviceStatus,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Service Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailItem(
            'Service Type',
            widget.service['type'],
            Icons.category,
          ),
          const SizedBox(height: 8),
          _buildDetailItem(
            'Date & Time',
            widget.service['time'],
            Icons.access_time,
          ),
          const SizedBox(height: 8),
          _buildDetailItem(
            'Payment',
            '${AppConstants.currencySymbol}${widget.service['payAmount'].toStringAsFixed(2)}',
            Icons.attach_money,
            valueColor: AppTheme.accentColor,
          ),
          const SizedBox(height: 8),
          _buildDetailItem(
            'Duration',
            widget.service['duration'] ?? '2 hours (estimated)',
            Icons.timelapse,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Service Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppTheme.accentColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.service['address'],
                      style: const TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to view on map',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Client Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[700],
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Smith',
                      style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+1 (555) 123-4567',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle phone call
                      _showContactDialog('call');
                    },
                    icon: const Icon(
                      Icons.call,
                      color: AppTheme.accentColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle message
                      _showContactDialog('message');
                    },
                    icon: const Icon(
                      Icons.message,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_serviceStatus == 'Pending') {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _isLoading ? null : () => _updateServiceStatus('Rejected'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.redAccent),
                  foregroundColor: Colors.redAccent,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.redAccent,
                        ),
                      )
                    : const Text('REJECT'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _updateServiceStatus('Accepted'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppTheme.accentColor,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('ACCEPT'),
              ),
            ),
          ],
        ),
      );
    } else if (_serviceStatus == 'Accepted') {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isLoading ? null : () => _updateServiceStatus('In Progress'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('START SERVICE'),
        ),
      );
    } else if (_serviceStatus == 'In Progress') {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isLoading ? null : () => _updateServiceStatus('Completed'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('MARK AS COMPLETED'),
        ),
      );
    } else if (_serviceStatus == 'Completed') {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Service Completed',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Show invoice/receipt
              },
              icon: const Icon(Icons.receipt_long),
              label: const Text('VIEW RECEIPT'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 20),
              ),
            ),
          ],
        ),
      );
    }
    
    return Container(); // Default empty container
  }

  Widget _buildDetailItem(String label, String value, IconData icon, {Color? valueColor}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: valueColor ?? AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _updateServiceStatus(String newStatus) {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call to update service status
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _serviceStatus = newStatus;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service status updated to $newStatus')),
      );

      if (newStatus == 'Rejected' || newStatus == 'Completed') {
        // After a short delay, go back to the previous screen
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context, {'status': newStatus});
        });
      }
    });
  }

  void _showContactDialog(String action) {
    String title = action == 'call' ? 'Call Client' : 'Message Client';
    String content = action == 'call'
        ? 'Are you sure you want to call the client?'
        : 'Are you sure you want to message the client?';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        title: Text(
          title,
          style: const TextStyle(color: AppTheme.textColor),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${action == 'call' ? 'Calling' : 'Messaging'} the client...')),
              );
            },
            child: Text(action == 'call' ? 'Call' : 'Message'),
          ),
        ],
      ),
    );
  }
} 