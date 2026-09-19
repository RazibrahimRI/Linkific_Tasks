import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final void Function(bool isDark) onThemeChanged;

  const SettingsScreen({super.key, required this.onThemeChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _isLoggedIn = false;
  bool _isFirstLaunch = true;
  String _language = 'English';
  int _loginCount = 0;
  double _fontSize = 16.0;
  List<String> _favoriteLanguages = [];

  final List<String> _availableLanguages = ['English', 'Malayalam', 'Hindi', 'Tamil'];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAllPreferences();
  }

  Future<void> _loadAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
      _language = prefs.getString('language') ?? 'English';
      _loginCount = prefs.getInt('loginCount') ?? 0;
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
      _favoriteLanguages = prefs.getStringList('favoriteLanguages') ?? [];
      _loading = false;
    });
    widget.onThemeChanged(_isDarkMode);

    if (_isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      setState(() => _isFirstLaunch = false);
    }
    await prefs.setInt('loginCount', _loginCount + 1);
    setState(() => _loginCount += 1);
  }


  Future<void> _setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() => _isDarkMode = value);
    widget.onThemeChanged(value);
  }

  Future<void> _setNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    setState(() => _notificationsEnabled = value);
  }

  Future<void> _setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    setState(() => _isLoggedIn = value);
  }

  Future<void> _setLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', value);
    setState(() => _language = value);
  }

  Future<void> _setFontSize(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', value);
    setState(() => _fontSize = value);
  }

  Future<void> _toggleFavoriteLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    final updated = List<String>.from(_favoriteLanguages);
    if (updated.contains(lang)) {
      updated.remove(lang);
    } else {
      updated.add(lang);
    }
    await prefs.setStringList('favoriteLanguages', updated);
    setState(() => _favoriteLanguages = updated);
  }

  Future<void> _removeLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('language');
    setState(() => _language = 'English');
    _showSnack('Language preference removed — reverted to default.');
  }

  Future<void> _clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _loadAllPreferences();
    _showSnack('All preferences cleared — app reset to defaults.');
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('First launch ever: ${_isFirstLaunch ? "Yes" : "No"}'),
          Text('App opened $_loginCount time(s) (int example)'),
          const Divider(height: 32),

          const Text('Theme', style: TextStyle(fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: _setDarkMode,
          ),

          const Divider(height: 32),
          const Text('Language', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: _language,
            items: _availableLanguages
                .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                .toList(),
            onChanged: (value) {
              if (value != null) _setLanguage(value);
            },
          ),
          TextButton(
            onPressed: _removeLanguagePreference,
            child: const Text('Remove Language Preference'),
          ),

          const Divider(height: 32),
          const Text('Favorite Languages (List<String> example)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: _availableLanguages.map((lang) {
              final selected = _favoriteLanguages.contains(lang);
              return FilterChip(
                label: Text(lang),
                selected: selected,
                onSelected: (_) => _toggleFavoriteLanguage(lang),
              );
            }).toList(),
          ),

          const Divider(height: 32),
          const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: _setNotifications,
          ),

          const Divider(height: 32),
          const Text('Login State', style: TextStyle(fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Remember Login'),
            value: _isLoggedIn,
            onChanged: _setLoggedIn,
          ),

          const Divider(height: 32),
          const Text('Font Size (double example)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _fontSize,
            min: 12,
            max: 24,
            divisions: 12,
            label: _fontSize.toStringAsFixed(1),
            onChanged: _setFontSize,
          ),
          Text('Preview text', style: TextStyle(fontSize: _fontSize)),

          const Divider(height: 32),
          ElevatedButton(
            onPressed: _clearAllPreferences,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All Preferences', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}