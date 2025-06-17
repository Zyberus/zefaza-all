# Zefaza Services

A premium mobile application for service providers to manage their service requests and availability.

## Features

### Modern Premium UI
- Sleek dark theme with gold accents
- Consistent design language matching other Zefaza applications
- Simple and intuitive interface with smooth transitions

### Service Provider Dashboard
- At-a-glance metrics for earnings and services
- Upcoming service requests with status indicators
- Accept/reject service requests directly from dashboard
- Smooth modal transitions instead of traditional navigation

### Modal Screens
- Edit Profile - Update personal information with real-time changes
- Help & Support - Direct customer support via chat, call, and email
- View All Services - Tab-based view of pending, ongoing, and completed services
- Account Settings - Gateway to notification and language settings

### Micro Modal Screens
- Notification Settings - Fine-grained control of app notifications
- Language Settings - Change app language with visual language picker

### Service Details Screen
- Comprehensive view of service requests
- Status management workflow (Accept → Start → Complete)
- Client information with contact options
- Location details with map integration
- Payment information

### Quick Settings
- Toggle availability status
- Account management
- Profile options

## Getting Started

This project is built with Flutter. To get started:

1. Ensure Flutter is installed on your development machine
2. Clone the repository
3. Run `flutter pub get` to install dependencies
4. Connect a device or start an emulator
5. Run `flutter run` to launch the application

## Project Structure

The app follows a simplified architecture with a single dashboard that contains multiple modals and one detail screen:

```
lib/
├── core/
│   ├── constants/
│   └── theme/
├── features/
│   ├── auth/
│   │   └── login_screen.dart
│   ├── bookings/
│   │   └── service_details_screen.dart
│   └── dashboard/
│       ├── screens/
│       │   └── simple_dashboard_screen.dart
│       └── widgets/
│           ├── edit_profile_modal.dart
│           ├── help_support_modal.dart
│           ├── all_services_modal.dart
│           ├── notification_settings_modal.dart
│           └── language_settings_modal.dart
└── main.dart
```

## Related Apps

This app is part of the Zefaza ecosystem that includes:
- Zefaza App (Customer App)
- Zefaza Delivery (Delivery Partners)
- Zefaza Seller (Merchant App)
- Zefaza Services (Service Providers)
