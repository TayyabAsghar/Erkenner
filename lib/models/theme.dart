// we use provider to manage the app state
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  double fontSize;

  ThemeProvider({this.isLightTheme, this.fontSize});

  ThemeData light = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      color: Color(0xff01A7E1),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xff133b5c),
  );

  ThemeData dark = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      color: Color(0xff1d2d50),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff0E1B2B), //0xff0e1b2b
  );

  ThemeData get getTheme {
    // Setting the Status/Navigation Bar color for every time app is open.
    applyStatusNavigationBarColor();
    return isLightTheme ? light : dark;
  }

  // the code below is to manage the status bar color when the theme changes
  applyStatusNavigationBarColor() {
    if (isLightTheme)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    else
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
  }

  toggleThemeData() async {
    final settings =
        await Hive.openBox('settings'); // Storing the data on local device
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    applyStatusNavigationBarColor();
    notifyListeners();
  }

  setFontSize(double _fontSize) async {
    final settings =
        await Hive.openBox('settings'); // Storing the data on local device
    settings.put('fontSize', _fontSize);
    fontSize = _fontSize;
    notifyListeners();
  }
}
// Provider finished
