import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  double fontSize;

  ThemeProvider({this.isLightTheme, this.fontSize});

  ThemeData light = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme:
        AppBarTheme(color: Colors.deepPurple[400]), // Still need to be set
    scaffoldBackgroundColor: Colors.white,
    //canvasColor: Color(0xFFA7C5EB),
    brightness: Brightness.light,
    buttonTheme: ButtonThemeData(
      minWidth: 100.0,
      height: 50.0,
      buttonColor: Colors.deepPurple[200],
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.italic,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      subtitle2: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
      ),
    ),
  );

  ThemeData dark = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(color: Color(0xFF1F1F1F)),
    scaffoldBackgroundColor: Color(0xFF121212),
    brightness: Brightness.dark,
    canvasColor: Color(0xFF121212),
    buttonTheme: ButtonThemeData(
      minWidth: 100.0,
      height: 50.0,
      buttonColor: Colors.deepPurple[200],
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.italic,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
    ),
  );

  ThemeData get getTheme {
    applyStatusNavigationBarColor(); // Setting the Status/Navigation Bar color for every-time app is open.
    return isLightTheme ? light : dark;
  }

  // the code below is to manage the status & navigation bar color when the theme changes
  applyStatusNavigationBarColor() {
    if (isLightTheme)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFF303F9F), //FF27679C
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFE7D9EA),
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    else
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFF121212),
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
