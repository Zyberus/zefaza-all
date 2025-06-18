class AppConstants {
  static const String appName = 'Zefaza Enterprise';
  
  // Common text
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String update = 'Update';
  static const String delete = 'Delete';
  static const String close = 'Close';
  
  // User role names
  static const String roleDelivery = 'Delivery Partner';
  static const String roleSeller = 'Seller';
  static const String roleService = 'Service Provider';
  static const String roleAdmin = 'Administrator';

  // Currency
  static const String currencySymbol = '\$';
  
  // Timeframe filters
  static const List<String> timeframes = ['Today', 'Week', 'Month', 'Year'];
  
  // Local storage keys
  static const String storageKeyToken = 'auth_token';
  static const String storageKeyUser = 'user_data';
  static const String storageKeyUserRole = 'user_role';
  
  // API endpoints would go here (for a real app)
  static const String baseUrl = 'https://api.zefaza.com';
  
  // App version
  static const String appVersion = '1.0.0';
} 