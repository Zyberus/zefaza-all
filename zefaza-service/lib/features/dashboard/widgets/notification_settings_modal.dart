import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class NotificationSettingsModal extends StatefulWidget {
  final Map<String, bool> notificationSettings;
  final Function(Map<String, bool>) onUpdate;
  
  const NotificationSettingsModal({
    Key? key, 
    required this.notificationSettings,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<NotificationSettingsModal> createState() => _NotificationSettingsModalState();
}

class _NotificationSettingsModalState extends State<NotificationSettingsModal> {
  late Map<String, bool> _settings;
  
  @override
  void initState() {
    super.initState();
    _settings = Map<String, bool>.from(widget.notificationSettings);
  }
  
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
          _buildOptions(),
          _buildActions(),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.notifications,
            color: AppTheme.accentColor,
            size: 24,
          ),
          SizedBox(width: 12),
          Text(
            'Notification Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          _buildSwitchTile(
            'New Service Requests',
            'Get notified when new service requests are available',
            'service_requests',
          ),
          const Divider(color: Colors.grey),
          _buildSwitchTile(
            'Service Reminders',
            'Receive reminders for upcoming services',
            'service_reminders',
          ),
          const Divider(color: Colors.grey),
          _buildSwitchTile(
            'Payment Updates',
            'Get notifications for new payments and earnings',
            'payment_updates',
          ),
          const Divider(color: Colors.grey),
          _buildSwitchTile(
            'App Updates',
            'Be notified about new app features and updates',
            'app_updates',
          ),
          const Divider(color: Colors.grey),
          _buildSwitchTile(
            'Marketing Messages',
            'Receive promotional offers and news',
            'marketing',
          ),
        ],
      ),
    );
  }
  
  Widget _buildSwitchTile(String title, String subtitle, String key) {
    // Initialize the value if it doesn't exist
    _settings.putIfAbsent(key, () => true);
    
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(color: AppTheme.textColor),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[500], fontSize: 12),
      ),
      value: _settings[key] ?? true,
      activeColor: AppTheme.accentColor,
      onChanged: (bool value) {
        setState(() {
          _settings[key] = value;
        });
      },
    );
  }
  
  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              widget.onUpdate(_settings);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification settings updated')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
            ),
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }
} 