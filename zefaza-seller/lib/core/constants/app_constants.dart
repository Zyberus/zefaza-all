class AppConstants {
  // App information
  static const String appName = 'Zefaza Seller';
  static const String appVersion = '1.0.0';
  
  // Navigation routes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String addProductRoute = '/add-product';
  static const String editProductRoute = '/edit-product';
  static const String orderDetailsRoute = '/order-details';
  static const String settingsRoute = '/settings';
  static const String analyticsRoute = '/analytics';
  
  // API endpoints (to be replaced with actual endpoints)
  static const String baseApiUrl = 'https://api.zefaza.com/v1';
  static const String authEndpoint = '$baseApiUrl/auth';
  static const String productsEndpoint = '$baseApiUrl/products';
  static const String ordersEndpoint = '$baseApiUrl/orders';
  static const String analyticsEndpoint = '$baseApiUrl/analytics';
  
  // Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';
  
  // Seller app specific
  static const int maxProductImages = 6;
  static const List<String> productCategories = [
    'Electronics',
    'Clothing',
    'Home & Kitchen',
    'Beauty & Personal Care',
    'Books',
    'Toys & Games',
    'Sports & Outdoors',
    'Automotive',
    'Health & Household',
    'Grocery',
    'Baby',
    'Pet Supplies',
  ];
  
  // Dashboard metrics
  static const List<String> timeframes = ['Today', 'Week', 'Month', 'Year'];
  
  // Order status
  static const List<String> orderStatuses = [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
    'Returned',
    'Refunded'
  ];
  
  // Currency symbol
  static const String currencySymbol = '\$';
} 