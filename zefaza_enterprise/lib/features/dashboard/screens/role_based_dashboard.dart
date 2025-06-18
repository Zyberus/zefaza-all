import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';
import '../../delivery/screens/delivery_dashboard.dart';
import '../../seller/screens/seller_dashboard.dart';
import '../../service/screens/service_dashboard.dart';

class RoleBasedDashboard extends StatelessWidget {
  const RoleBasedDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userType = authProvider.userType;

    // Show loading indicator if we're still checking user type
    if (authProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Redirect to appropriate dashboard based on user type
    switch (userType) {
      case UserType.delivery:
        return const DeliveryDashboard();
      case UserType.seller:
        return const SellerDashboard();
      case UserType.service:
        return const ServiceDashboard();
      case UserType.admin:
        // Admin dashboard would go here if implemented
        return const AdminDashboard();
      default:
        // If no user type is found, show a welcome screen with options
        return _buildWelcomeScreen(context);
    }
  }

  // Build a welcome screen for when user type is not determined
  Widget _buildWelcomeScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
              color: AppTheme.accentColor,
            ),
            const SizedBox(height: 24),
            const Text(
              'User role not found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'We could not determine your user role. Please sign out and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              ),
              onPressed: () {
                // Sign out the user
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                authProvider.signOut();
                
                // Navigate back to login screen
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

// Basic admin dashboard (placeholder)
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: const Center(
        child: Text('Admin Dashboard - Not yet implemented'),
      ),
    );
  }
} 