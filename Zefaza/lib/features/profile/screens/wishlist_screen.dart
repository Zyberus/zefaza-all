import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'id': '1',
      'name': 'Premium Leather Jacket',
      'price': 599.99,
      'originalPrice': 899.99,
      'discount': 33,
      'rating': 4.8,
      'reviews': 234,
      'isPrime': true,
      'inStock': true,
      'image': Icons.checkroom,
    },
    {
      'id': '2',
      'name': 'Wireless Noise Cancelling Headphones',
      'price': 299.99,
      'originalPrice': 399.99,
      'discount': 25,
      'rating': 4.6,
      'reviews': 1542,
      'isPrime': true,
      'inStock': true,
      'image': Icons.headphones,
    },
    {
      'id': '3',
      'name': 'Smart Watch Series 8',
      'price': 449.99,
      'originalPrice': 499.99,
      'discount': 10,
      'rating': 4.7,
      'reviews': 892,
      'isPrime': false,
      'inStock': false,
      'image': Icons.watch,
    },
    {
      'id': '4',
      'name': 'Professional Camera Lens',
      'price': 1299.99,
      'originalPrice': 1599.99,
      'discount': 19,
      'rating': 4.9,
      'reviews': 156,
      'isPrime': true,
      'inStock': true,
      'image': Icons.camera,
    },
  ];

  void _removeFromWishlist(String id) {
    setState(() {
      _wishlistItems.removeWhere((item) => item['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        title: const Text('My Wishlist'),
        centerTitle: true,
        actions: [
          if (_wishlistItems.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  _wishlistItems.clear();
                });
              },
              child: const Text(
                'Clear All',
                style: TextStyle(color: AppTheme.darkGray),
              ),
            ),
        ],
      ),
      body: _wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : Column(
              children: [
                // Summary Bar
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingM),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_wishlistItems.length} items saved',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _wishlistItems.any((item) => item['inStock'] == true)
                            ? () {
                                // Add all in-stock items to cart
                              }
                            : null,
                        icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                        label: const Text('Add All to Cart'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlack,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingM,
                            vertical: AppConstants.paddingS,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Wishlist Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.paddingM),
                    itemCount: _wishlistItems.length,
                    itemBuilder: (context, index) {
                      final item = _wishlistItems[index];
                      return _buildWishlistItem(item);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 60,
                color: AppTheme.mediumGray,
              ),
            ),
            const SizedBox(height: AppConstants.spacingL),
            Text(
              'Your wishlist is empty',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              'Save items you want to buy later',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.darkGray,
              ),
            ),
            const SizedBox(height: AppConstants.spacingXL),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> item) {
    final bool inStock = item['inStock'] ?? true;
    
    return Dismissible(
      key: Key(item['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
        decoration: BoxDecoration(
          color: AppTheme.accentRed,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppConstants.paddingL),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (direction) {
        final removedItem = item;
        _removeFromWishlist(item['id']);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item['name']} removed from wishlist'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _wishlistItems.add(removedItem);
                });
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.lightGray,
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            item['image'] as IconData,
                            size: 48,
                            color: AppTheme.mediumGray,
                          ),
                        ),
                        if (item['isPrime'] == true)
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlack,
                                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.flash_on,
                                    size: 10,
                                    color: AppTheme.premiumGold,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    'PRIME',
                                    style: TextStyle(
                                      color: AppTheme.premiumGold,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!inStock)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(AppConstants.radiusM),
                            ),
                            child: const Center(
                              child: Text(
                                'Out of Stock',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  
                  // Product Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        
                        // Rating
                        Row(
                          children: [
                            ...List.generate(5, (index) => Icon(
                              index < item['rating'].floor() ? Icons.star : Icons.star_border,
                              size: 14,
                              color: Colors.amber[700],
                            )),
                            const SizedBox(width: 4),
                            Text(
                              '${item['rating']}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${item['reviews']})',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.darkGray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        
                        // Price
                        Row(
                          children: [
                            if (item['discount'] != null && item['discount'] > 0) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentRed,
                                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                                ),
                                child: Text(
                                  '-${item['discount']}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              '\$${item['price']}',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            if (item['originalPrice'] != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                '\$${item['originalPrice']}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppTheme.darkGray,
                                ),
                              ),
                            ],
                          ],
                        ),
                        
                        if (item['isPrime'] == true && inStock) ...[
                          const SizedBox(height: 4),
                          Text(
                            'FREE Prime Delivery',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.darkGray,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Action Buttons
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(AppConstants.radiusL),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _removeFromWishlist(item['id']);
                      },
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Remove'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.darkGray,
                        side: const BorderSide(color: AppTheme.mediumGray),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingS),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: inStock ? () {} : null,
                      icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                      label: Text(inStock ? 'Add to Cart' : 'Out of Stock'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: inStock ? AppTheme.premiumGold : AppTheme.mediumGray,
                        foregroundColor: inStock ? AppTheme.primaryBlack : AppTheme.darkGray,
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
} 