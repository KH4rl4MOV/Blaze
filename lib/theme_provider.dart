import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  int _themeIndex = 0;

  int get themeIndex => _themeIndex;

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeIndex = prefs.getInt('themeIndex') ?? 0;
    notifyListeners();
  }

  Future<void> setTheme(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeIndex = index;
    await prefs.setInt('themeIndex', index);
    notifyListeners();
  }

  String getBackgroundImage() {
    switch (_themeIndex) {
      case 0:
        return 'assets/theme1.jpg';
      case 1:
        return 'assets/theme2.jpg';
      case 2:
        return 'assets/theme3.jpg';
      default:
        return 'assets/theme1.jpg';
    }
  }
}
