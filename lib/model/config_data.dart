import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigData with ChangeNotifier {
  ConfigData() {
    loadSharedPreferences();
  }
  bool isDarkMode = false;
  ThemeData themeData = ThemeData();
  late SharedPreferences prefs;

  loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  darkModeChange() {
    isDarkMode = !isDarkMode;
    prefs.setBool('isDarkMode', isDarkMode);
    notifyListeners();
  }

  justNotify() {
    notifyListeners();
  }
}
