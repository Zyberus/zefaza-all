import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LanguageSettingsModal extends StatefulWidget {
  final String currentLanguage;
  final Function(String) onUpdate;
  
  const LanguageSettingsModal({
    Key? key, 
    required this.currentLanguage,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<LanguageSettingsModal> createState() => _LanguageSettingsModalState();
}

class _LanguageSettingsModalState extends State<LanguageSettingsModal> {
  late String _selectedLanguage;
  
  final List<Map<String, dynamic>> _languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'es', 'name': 'Spanish', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'French', 'flag': '🇫🇷'},
    {'code': 'ar', 'name': 'Arabic', 'flag': '🇦🇪'},
    {'code': 'zh', 'name': 'Chinese', 'flag': '🇨🇳'},
    {'code': 'hi', 'name': 'Hindi', 'flag': '🇮🇳'},
    {'code': 'pt', 'name': 'Portuguese', 'flag': '🇧🇷'},
    {'code': 'ru', 'name': 'Russian', 'flag': '🇷🇺'},
    {'code': 'ja', 'name': 'Japanese', 'flag': '🇯🇵'},
    {'code': 'de', 'name': 'German', 'flag': '🇩🇪'},
  ];
  
  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage;
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: _buildLanguageList(),
          ),
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
      child: Row(
        children: [
          const Icon(
            Icons.language,
            color: AppTheme.accentColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          const Text(
            'Language Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _languages.firstWhere((lang) => lang['code'] == _selectedLanguage, orElse: () => _languages[0])['flag'],
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLanguageList() {
    return ListView.builder(
      itemCount: _languages.length,
      itemBuilder: (context, index) {
        final language = _languages[index];
        final isSelected = language['code'] == _selectedLanguage;
        
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedLanguage = language['code'];
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: Text(
                  language['flag'],
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  language['name'],
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: isSelected 
                    ? const Icon(Icons.check_circle, color: AppTheme.accentColor)
                    : null,
                tileColor: isSelected ? AppTheme.accentColor.withOpacity(0.1) : null,
                shape: isSelected
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppTheme.accentColor, width: 1),
                      )
                    : null,
              ),
            ),
          ),
        );
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
              widget.onUpdate(_selectedLanguage);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Language updated to ${_languages.firstWhere((lang) => lang['code'] == _selectedLanguage)['name']}'
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
            ),
            child: const Text('APPLY'),
          ),
        ],
      ),
    );
  }
} 