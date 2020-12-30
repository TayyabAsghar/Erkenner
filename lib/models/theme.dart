import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  double fontSize;

  ThemeProvider({this.isLightTheme, this.fontSize});

  ThemeData light = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(color: Color(0xFF01A7E1)),
    scaffoldBackgroundColor: Color(0xFF27679C),
    canvasColor: Color(0xFFA7C5EB),
    brightness: Brightness.light,
  );

  ThemeData dark = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(color: Color(0xFF1D2D50)),
    scaffoldBackgroundColor: Color(0xFF0E1B2B),
    brightness: Brightness.dark,
  );

  ThemeData get getTheme {
    applyStatusNavigationBarColor(); // Setting the Status/Navigation Bar color for every-time app is open.
    return isLightTheme ? light : dark;
  }

  // the code below is to manage the status & navigation bar color when the theme changes
  applyStatusNavigationBarColor() {
    if (isLightTheme)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFF27679C),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFE7D9EA),
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    else
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFF0E1B2B),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
  }

  toggleThemeData() async {
    final settings = await Hive.openBox('settings');
    settings.put('isLightTheme', !isLightTheme); // Storing data on local device
    isLightTheme = !isLightTheme;
    applyStatusNavigationBarColor();
    notifyListeners();
  }

  setFontSize(double _fontSize) async {
    final settings = await Hive.openBox('settings');
    settings.put('fontSize', _fontSize); // Storing data on local device
    fontSize = _fontSize;
    notifyListeners();
  }
}
