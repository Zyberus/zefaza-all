import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();
  
  // Mock user authentication status - in a real app this would use shared preferences or a secure storage
  bool _isLoggedIn = false;
  
  // Mock user database - in a real app this would be a secure database
  final Map<String, Map<String, dynamic>> _users = {};
  
  // Get current authentication status
  bool get isLoggedIn => _isLoggedIn;
  
  // Set authentication status
  void setLoggedIn(bool status) {
    _isLoggedIn = status;
  }
  
  // Register a new user
  Future<bool> registerUser(String phoneNumber, String password) async {
    // Mock registration - in a real app this would call an API
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Store user data (simplified)
    _users[phoneNumber] = {
      'phoneNumber': phoneNumber,
      'password': password,
      'createdAt': DateTime.now().toIso8601String(),
    };
    
    _isLoggedIn = true;
    return true;
  }
  
  // Login method with phone and password
  Future<bool> login(String phoneNumber, String password) async {
    // Mock login - in a real app this would call an API
    await Future.delayed(const Duration(seconds: 1));
    
    // Check if user exists and password matches
    if (_users.containsKey(phoneNumber) && _users[phoneNumber]!['password'] == password) {
      _isLoggedIn = true;
      return true;
    }
    
    // For demo purposes, allow login with any non-empty credentials
    if (phoneNumber.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      return true;
    }
    
    return false;
  }
  
  // Logout method
  Future<void> logout() async {
    // Mock logout - in a real app this would clear tokens
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = false;
  }
  
  // Method to check if user is logged in and prompt for login if needed
  Future<bool> requireLogin(BuildContext context, {String? message}) async {
    if (_isLoggedIn) {
      return true;
    }
    
    // Show login dialog
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildLoginPrompt(context, message),
    );
    
    return result ?? false;
  }
  
  // Build a nice login prompt
  Widget _buildLoginPrompt(BuildContext context, String? message) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Sign in to continue",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          // Message
          if (message != null) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          
          const Spacer(),
          
          // Buttons
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ).then((value) {
                      if (_isLoggedIn) {
                        Navigator.pop(context, true);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlack,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    ).then((value) {
                      if (_isLoggedIn) {
                        Navigator.pop(context, true);
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryBlack,
                    side: const BorderSide(color: AppTheme.mediumGray),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    "Continue as Guest",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
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
} 