class AppConstants {
  // App information
  static const String appName = 'Zefaza Delivery';
  static const String appVersion = '1.0.0';
  
  // Navigation routes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String deliveryDetailsRoute = '/delivery-details';
  static const String settingsRoute = '/settings';
  static const String earningsRoute = '/earnings';
  
  // API endpoints (to be replaced with actual endpoints)
  static const String baseApiUrl = 'https://api.zefaza.com/v1';
  static const String authEndpoint = '$baseApiUrl/auth';
  static const String deliveriesEndpoint = '$baseApiUrl/deliveries';
  static const String earningsEndpoint = '$baseApiUrl/earnings';
  
  // Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';
  static const String mapStylePath = 'assets/map_style.json';
  
  // Delivery app specific
  static const double defaultMapZoom = 15.0;
  static const int maxBatchDeliveries = 5;
  static const int refreshInterval = 60; // in seconds
  
  // Dashboard metrics
  static const List<String> timeframes = ['Today', 'Week', 'Month', 'Year'];
  
  // Delivery status
  static const List<String> deliveryStatuses = [
    'Pending',
    'Accepted',
    'Picked Up',
    'In Transit',
    'Delivered',
    'Failed',
    'Cancelled'
  ];
  
  // Currency symbol
  static const String currencySymbol = '\$';
} 