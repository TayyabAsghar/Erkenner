// we use provider to manage the app state
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  int fontSize;

  ThemeProvider({this.isLightTheme});
  //ThemeProvider({this.fontSize});

  ThemeData light = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      color: Color(0xff01A7E1),
    ),
    //primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
    //primaryColor: isLightTheme ? Colors.white : Color(0xFF1E1F28),
    brightness: Brightness.light,
    //backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242e),
    scaffoldBackgroundColor: Color(0xff133b5c),
  );

  ThemeData dark = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      color: Color(0xff1d2d50),
    ),
    //primarySwatch: Colors.grey,
    //primaryColor: Color(0xFF1E1F28),
    brightness: Brightness.dark,
    //backgroundColor: Color(0xFF26242e),
    scaffoldBackgroundColor: Color(0xff0e1b2b),
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

  toggleThemeFontSize() async {
    final settings =
        await Hive.openBox('settings'); // Storing the data on local device
    settings.put('fontSize', !isLightTheme);
    isLightTheme = !isLightTheme;
    applyStatusNavigationBarColor();
    notifyListeners();
  }
}
// Provider finished
