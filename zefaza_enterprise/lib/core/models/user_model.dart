import '../theme/app_theme.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserType userType;
  final String? profileImage;
  final Map<String, dynamic> additionalData; // For user type specific data

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    this.profileImage,
    this.additionalData = const {},
  });

  // Create a user from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    // Convert string user type to enum
    UserType type = UserType.values.firstWhere(
      (e) => e.toString().split('.').last == json['userType'],
      orElse: () => UserType.delivery,
    );

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      userType: type,
      profileImage: json['profileImage'],
      additionalData: json['additionalData'] ?? {},
    );
  }

  // Convert user to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType.toString().split('.').last,
      'profileImage': profileImage,
      'additionalData': additionalData,
    };
  }

  // Get user role display name
  String get roleName {
    switch (userType) {
      case UserType.delivery:
        return 'Delivery Partner';
      case UserType.seller:
        return 'Seller';
      case UserType.service:
        return 'Service Provider';
      case UserType.admin:
        return 'Administrator';
      default:
        return 'User';
    }
  }
} 