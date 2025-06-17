import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HelpSupportModal extends StatelessWidget {
  const HelpSupportModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact Customer Support',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Our support team is available 24/7 to assist you with any questions or issues you may have.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                _buildContactOptions(context),
                const SizedBox(height: 24),
                _buildChatSection(context),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.accentColor,
                    ),
                    child: const Text('CLOSE'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.support_agent,
            color: AppTheme.accentColor,
            size: 28,
          ),
          SizedBox(width: 12),
          Text(
            'Help & Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildContactButton(
            'Call Us',
            Icons.phone,
            Colors.green.shade700,
            () {
              _showActionDialog(
                context, 
                'Call Customer Support', 
                'You will be connected to our support team.\nPhone: +1 (800) 555-1234',
                'Call Now',
                () => _handleSupportAction(context, 'call')
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildContactButton(
            'Email Us',
            Icons.email,
            Colors.blue.shade700,
            () {
              _showActionDialog(
                context, 
                'Email Customer Support', 
                'Send us an email and we\'ll get back to you within 24 hours.\nEmail: support@zefaza.com',
                'Compose Email',
                () => _handleSupportAction(context, 'email')
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactButton(
    String label, 
    IconData icon, 
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chat,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Chat Support',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  Text(
                    'Chat with an agent right now',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'Online',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _handleSupportAction(context, 'chat'),
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('START CHAT'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Average response time: <1 minute',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showActionDialog(
    BuildContext context,
    String title,
    String message,
    String actionText,
    VoidCallback onAction,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        title: Text(
          title,
          style: const TextStyle(color: AppTheme.textColor),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onAction();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
            ),
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  void _handleSupportAction(BuildContext context, String action) {
    String message;
    
    switch (action) {
      case 'call':
        message = 'Initiating call to customer support...';
        break;
      case 'email':
        message = 'Opening email client...';
        break;
      case 'chat':
        message = 'Starting live chat with support...';
        break;
      default:
        message = 'Connecting to support...';
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    
    // Here you would actually initiate the appropriate action
    // For now we'll just close the modal
    Navigator.pop(context);
  }
} 