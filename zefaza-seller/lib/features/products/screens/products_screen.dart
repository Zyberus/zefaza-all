import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Filter values
  String _selectedCategory = 'All Categories';
  String _sortBy = 'Newest';
  
  // Mock products data
  final List<Map<String, dynamic>> _products = [
    {
      'id': 'P1001',
      'name': 'Premium Wireless Headphones',
      'price': 129.99,
      'stock': 45,
      'category': 'Electronics',
      'rating': 4.8,
      'sales': 234,
      'image': 'assets/images/placeholder.png',
      'isActive': true,
    },
    {
      'id': 'P1002',
      'name': 'Smart Watch Series 5',
      'price': 199.99,
      'stock': 28,
      'category': 'Electronics',
      'rating': 4.6,
      'sales': 187,
      'image': 'assets/images/placeholder.png',
      'isActive': true,
    },
    {
      'id': 'P1003',
      'name': 'Ergonomic Office Chair',
      'price': 149.99,
      'stock': 15,
      'category': 'Home & Kitchen',
      'rating': 4.5,
      'sales': 98,
      'image': 'assets/images/placeholder.png',
      'isActive': true,
    },
    {
      'id': 'P1004',
      'name': 'Ultra HD 4K Monitor',
      'price': 349.99,
      'stock': 12,
      'category': 'Electronics',
      'rating': 4.7,
      'sales': 76,
      'image': 'assets/images/placeholder.png',
      'isActive': true,
    },
    {
      'id': 'P1005',
      'name': 'Professional Knife Set',
      'price': 89.99,
      'stock': 23,
      'category': 'Home & Kitchen',
      'rating': 4.4,
      'sales': 112,
      'image': 'assets/images/placeholder.png',
      'isActive': false,
    },
    {
      'id': 'P1006',
      'name': 'Leather Laptop Bag',
      'price': 79.99,
      'stock': 8,
      'category': 'Accessories',
      'rating': 4.3,
      'sales': 65,
      'image': 'assets/images/placeholder.png',
      'isActive': true,
    },
  ];
  
  // Filtered products based on selected filters
  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) {
      // Filter by category
      if (_selectedCategory != 'All Categories' && 
          product['category'] != _selectedCategory) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildFilterOptions(),
            Expanded(
              child: _buildProductsList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentColor,
        onPressed: () {
          // Navigate to add product screen
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Products',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage your store inventory',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Category dropdown
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  isDense: true,
                  isExpanded: true,
                  style: const TextStyle(color: AppTheme.textColor),
                  dropdownColor: AppTheme.cardColor,
                  items: [
                    'All Categories',
                    ...AppConstants.productCategories,
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Sort dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortBy,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                isDense: true,
                style: const TextStyle(color: AppTheme.textColor),
                dropdownColor: AppTheme.cardColor,
                items: ['Newest', 'Best Selling', 'Price: High-Low', 'Price: Low-High']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sortBy = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return _filteredProducts.isEmpty
        ? const Center(
            child: Text(
              'No products found',
              style: TextStyle(color: Colors.grey),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];
              return _buildProductCard(product);
            },
          );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Product details row
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                // Product image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.inventory_2,
                      color: AppTheme.accentColor,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // Product info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: product['isActive']
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              product['isActive'] ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color:
                                    product['isActive'] ? Colors.green : Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // More options button
                          IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _showProductOptions(context, product);
                            },
                          ),
                        ],
                      ),
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'ID: ${product['id']}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${AppConstants.currencySymbol}${product['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.accentColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${product['sales']} sold',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Stock: ${product['stock']}',
                            style: TextStyle(
                              color: product['stock'] < 10 ? Colors.orange : Colors.grey,
                              fontSize: 12,
                              fontWeight: product['stock'] < 10 ? FontWeight.bold : FontWeight.normal,
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
          // Action buttons
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF333333),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      // Edit product
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                    ),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    color: Color(0xFF333333),
                    width: 1,
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      // Toggle product status
                      setState(() {
                        product['isActive'] = !product['isActive'];
                      });
                    },
                    icon: Icon(
                      product['isActive'] ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 18,
                    ),
                    label: Text(product['isActive'] ? 'Deactivate' : 'Activate'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProductOptions(BuildContext context, Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: AppTheme.textColor),
              title: const Text('Edit Product', style: TextStyle(color: AppTheme.textColor)),
              onTap: () {
                Navigator.pop(context);
                // Navigate to edit product
              },
            ),
            ListTile(
              leading: Icon(
                product['isActive'] ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppTheme.textColor,
              ),
              title: Text(
                product['isActive'] ? 'Deactivate Product' : 'Activate Product',
                style: const TextStyle(color: AppTheme.textColor),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  product['isActive'] = !product['isActive'];
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.content_copy_outlined, color: AppTheme.textColor),
              title: const Text('Duplicate Product', style: TextStyle(color: AppTheme.textColor)),
              onTap: () {
                Navigator.pop(context);
                // Duplicate product logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete Product', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                // Show delete confirmation
                _showDeleteConfirmation(context, product);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardColor,
          title: const Text(
            'Delete Product',
            style: TextStyle(color: AppTheme.textColor),
          ),
          content: Text(
            'Are you sure you want to delete "${product['name']}"? This action cannot be undone.',
            style: const TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Delete product logic
                setState(() {
                  _products.removeWhere((p) => p['id'] == product['id']);
                });
                
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product['name']} has been deleted'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
} 