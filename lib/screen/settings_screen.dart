import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedThemeIndex = 0;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedThemeIndex = prefs.getInt('themeIndex') ?? 0;
      _selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', _selectedThemeIndex);
    await prefs.setString('language', _selectedLanguage);
    // Обновление фона или языка в приложении
  }

  void _changeTheme(int index) {
    setState(() {
      _selectedThemeIndex = index;
    });
    _saveSettings();
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    _saveSettings();
    // Переключение языка в приложении
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose A Theme',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildThemeButton(0, 'assets/theme1.jpg'),
                _buildThemeButton(1, 'assets/theme2.jpg'),
                _buildThemeButton(2, 'assets/theme3.jpg'),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Language',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedLanguage,
              dropdownColor: Colors.grey[800],
              items: ['English', 'Русский'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeLanguage(newValue);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton(int index, String imagePath) {
    return GestureDetector(
      onTap: () => _changeTheme(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedThemeIndex == index ? Colors.red : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
