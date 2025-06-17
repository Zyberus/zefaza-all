import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../bookings/screens/service_details_screen.dart';

class AllServicesModal extends StatefulWidget {
  final List<Map<String, dynamic>> services;
  
  const AllServicesModal({
    Key? key,
    required this.services,
  }) : super(key: key);

  @override
  State<AllServicesModal> createState() => _AllServicesModalState();
}

class _AllServicesModalState extends State<AllServicesModal> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  
  // Filtered service lists
  late List<Map<String, dynamic>> _pendingServices;
  late List<Map<String, dynamic>> _acceptedServices;
  late List<Map<String, dynamic>> _completedServices;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    
    // Initialize filtered lists
    _filterServices();
    
    // Add some mock data if the original list is too small
    _addMockServicesIfNeeded();
  }
  
  void _filterServices() {
    _pendingServices = widget.services.where((service) => service['status'] == 'Pending').toList();
    _acceptedServices = widget.services.where((service) => 
      service['status'] == 'Accepted' || service['status'] == 'In Progress').toList();
    _completedServices = widget.services.where((service) => service['status'] == 'Completed').toList();
  }
  
  void _addMockServicesIfNeeded() {
    // Add mock data for completed services if necessary
    if (_completedServices.length < 3) {
      _completedServices.addAll([
        {
          'id': '#SVC0987',
          'type': 'Plumbing',
          'time': 'Yesterday, 2:30 PM',
          'address': '789 Pine Dr, Anytown, USA',
          'status': 'Completed',
          'payAmount': 120.00,
        },
        {
          'id': '#SVC0965',
          'type': 'Electrical',
          'time': 'Aug 25, 10:15 AM',
          'address': '456 Oak Ln, Somecity, USA',
          'status': 'Completed',
          'payAmount': 89.50,
        },
      ]);
    }

    // Add mock data for pending services if necessary
    if (_pendingServices.length < 2) {
      _pendingServices.add(
        {
          'id': '#SVC1003',
          'type': 'Home Cleaning',
          'time': 'Tomorrow, 9:00 AM',
          'address': '321 Elm St, Othertown, USA',
          'status': 'Pending',
          'payAmount': 65.00,
        },
      );
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildServicesList(_pendingServices),
                _buildServicesList(_acceptedServices),
                _buildServicesList(_completedServices),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Services',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppTheme.accentColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: AppTheme.textColor),
            decoration: InputDecoration(
              hintText: 'Search services by ID or type...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: const Icon(Icons.search, color: AppTheme.accentColor),
              filled: true,
              fillColor: AppTheme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTabBar() {
    return Container(
      color: AppTheme.primaryColor,
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.accentColor,
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppTheme.accentColor,
        tabs: const [
          Tab(text: 'PENDING'),
          Tab(text: 'ONGOING'),
          Tab(text: 'COMPLETED'),
        ],
      ),
    );
  }
  
  Widget _buildServicesList(List<Map<String, dynamic>> services) {
    if (services.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(service);
      },
    );
  }
  
  Widget _buildEmptyState() {
    String message;
    IconData icon;
    
    switch (_selectedIndex) {
      case 0:
        message = 'No pending service requests';
        icon = Icons.pending_actions;
        break;
      case 1:
        message = 'No ongoing services';
        icon = Icons.assignment_ind;
        break;
      case 2:
        message = 'No completed services yet';
        icon = Icons.assignment_turned_in;
        break;
      default:
        message = 'No services found';
        icon = Icons.assignment;
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedIndex == 0
                ? 'New service requests will appear here'
                : _selectedIndex == 1
                    ? 'Accepted services will appear here'
                    : 'Your service history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
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
            : service['status'] == 'In Progress'
                ? Colors.purple
                : Colors.green;
                
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToServiceDetails(service),
        borderRadius: BorderRadius.circular(12),
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        _getServiceIcon(service['type']),
                        color: AppTheme.accentColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        service['type'],
                        style: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        service['time'],
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${service['status'] == 'Completed' ? 'Earned' : 'Payment'}:',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '\$${service['payAmount'].toStringAsFixed(2)}',
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
          ],
        ),
      ),
    );
  }
  
  IconData _getServiceIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cleaning':
        return Icons.cleaning_services;
      case 'plumbing':
        return Icons.plumbing;
      case 'electrical':
        return Icons.electrical_services;
      case 'cooking':
        return Icons.restaurant;
      case 'home cleaning':
        return Icons.home;
      default:
        return Icons.miscellaneous_services;
    }
  }
  
  void _navigateToServiceDetails(Map<String, dynamic> service) {
    Navigator.pop(context); // Close modal first
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceDetailsScreen(service: service),
      ),
    ).then((result) {
      if (result != null && result is Map<String, dynamic> && result.containsKey('status')) {
        // Handle status update if needed
      }
    });
  }
} 