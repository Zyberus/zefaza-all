class AppConstants {
  // App information
  static const String appName = 'Zefaza Services';
  static const String appVersion = '1.0.0';
  
  // Navigation routes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String serviceDetailsRoute = '/service-details';
  static const String settingsRoute = '/settings';
  static const String earningsRoute = '/earnings';
  static const String serviceHistoryRoute = '/service-history';
  
  // API endpoints (to be replaced with actual endpoints)
  static const String baseApiUrl = 'https://api.zefaza.com/v1';
  static const String authEndpoint = '$baseApiUrl/auth';
  static const String servicesEndpoint = '$baseApiUrl/services';
  static const String earningsEndpoint = '$baseApiUrl/earnings';
  
  // Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';
  
  // Services app specific
  static const int refreshInterval = 60; // in seconds
  static const int maxActiveServices = 3;
  
  // Dashboard metrics
  static const List<String> timeframes = ['Today', 'Week', 'Month', 'Year'];
  
  // Service status
  static const List<String> serviceStatuses = [
    'Pending',
    'Accepted',
    'In Progress',
    'Completed',
    'Cancelled',
    'Rescheduled'
  ];

  // Service categories
  static const List<String> serviceCategories = [
    'Cleaning',
    'Cooking',
    'Repair',
    'Electrical',
    'Plumbing',
    'Babysitting',
    'Tutoring',
    'Gardening',
    'Pet Care',
    'Beauty & Wellness',
    'Event Planning',
    'Other'
  ];
  
  // Currency symbol
  static const String currencySymbol = '\$';
} 