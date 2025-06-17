import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'color': Color(0xFFE91E63),
      'itemCount': '10M+',
      'subcategories': ['Men', 'Women', 'Kids', 'Shoes', 'Accessories'],
    },
    {
      'name': 'Electronics',
      'icon': Icons.devices,
      'color': Color(0xFF2196F3),
      'itemCount': '5M+',
      'subcategories': ['Phones', 'Laptops', 'Audio', 'Gaming', 'Smart Home'],
    },
    {
      'name': 'Home & Kitchen',
      'icon': Icons.home,
      'color': Color(0xFF4CAF50),
      'itemCount': '8M+',
      'subcategories': ['Furniture', 'Decor', 'Kitchen', 'Bedding', 'Storage'],
    },
    {
      'name': 'Beauty',
      'icon': Icons.face,
      'color': Color(0xFF9C27B0),
      'itemCount': '3M+',
      'subcategories': ['Skincare', 'Makeup', 'Hair', 'Fragrance', 'Tools'],
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_basketball,
      'color': Color(0xFFFF5722),
      'itemCount': '2M+',
      'subcategories': ['Fitness', 'Outdoor', 'Team Sports', 'Yoga', 'Cycling'],
    },
    {
      'name': 'Books',
      'icon': Icons.menu_book,
      'color': Color(0xFF795548),
      'itemCount': '15M+',
      'subcategories': ['Fiction', 'Non-Fiction', 'Comics', 'Textbooks', 'E-books'],
    },
    {
      'name': 'Toys & Games',
      'icon': Icons.toys,
      'color': Color(0xFF00BCD4),
      'itemCount': '4M+',
      'subcategories': ['Action Figures', 'Board Games', 'Dolls', 'Educational', 'Outdoor'],
    },
    {
      'name': 'Automotive',
      'icon': Icons.directions_car,
      'color': Color(0xFF607D8B),
      'itemCount': '1M+',
      'subcategories': ['Parts', 'Tools', 'Accessories', 'Oils', 'Tires'],
    },
    {
      'name': 'Health',
      'icon': Icons.favorite,
      'color': Color(0xFFF44336),
      'itemCount': '2M+',
      'subcategories': ['Vitamins', 'Personal Care', 'Medical', 'Fitness', 'Wellness'],
    },
    {
      'name': 'Pet Supplies',
      'icon': Icons.pets,
      'color': Color(0xFFFF9800),
      'itemCount': '1M+',
      'subcategories': ['Dogs', 'Cats', 'Fish', 'Birds', 'Small Animals'],
    },
    {
      'name': 'Groceries',
      'icon': Icons.shopping_basket,
      'color': Color(0xFF8BC34A),
      'itemCount': '500K+',
      'subcategories': ['Fresh', 'Pantry', 'Snacks', 'Beverages', 'Organic'],
    },
    {
      'name': 'Arts & Crafts',
      'icon': Icons.palette,
      'color': Color(0xFF3F51B5),
      'itemCount': '1M+',
      'subcategories': ['Painting', 'Drawing', 'Crafting', 'Sewing', 'Jewelry'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        title: const Text('All Categories'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Featured Categories Banner
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              margin: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryBlack, Color(0xFF2C2C2C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.premiumGold.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Explore All Categories',
                          style: TextStyle(
                            color: AppTheme.softWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Over 50 million products across all categories',
                          style: TextStyle(
                            color: AppTheme.softWhite.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Categories Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: AppConstants.spacingM,
                mainAxisSpacing: AppConstants.spacingM,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildCategoryCard(context, _categories[index]),
                childCount: _categories.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spacingXL),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        // Navigate to category products
      },
      child: Container(
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
        child: Stack(
          children: [
            // Background Gradient
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  
                  // Category Name
                  Text(
                    category['name'] as String,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Item Count
                  Text(
                    '${category['itemCount']} items',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.darkGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Subcategories Preview
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: (category['subcategories'] as List<String>)
                        .take(3)
                        .map((sub) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.lightGray,
                                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                              ),
                              child: Text(
                                sub,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.darkGray,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            
            // Arrow Icon
            const Positioned(
              bottom: 16,
              right: 16,
              child: Icon(
                Icons.arrow_forward,
                size: 16,
                color: AppTheme.darkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 