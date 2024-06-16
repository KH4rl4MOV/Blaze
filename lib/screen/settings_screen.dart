import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme_provider.dart';

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
  }

  void _changeTheme(int index) {
    setState(() {
      _selectedThemeIndex = index;
    });
    _saveSettings();
    Provider.of<ThemeProvider>(context, listen: false).setTheme(index);
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeProvider.getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose A Theme',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Image.asset(
                      'assets/lang_icon.png',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: DropdownButton<String>(
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
                        iconEnabledColor: Colors.white,
                        underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
