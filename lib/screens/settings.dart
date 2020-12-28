import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/models/theme.dart';

class Settings extends StatelessWidget {
  final double fontSize;
  final smallFonts = 14.0;
  final mediumFonts = 16.0;
  final largeFonts = 22.0;

  Settings({@required this.fontSize});

  int selectedRadio() {
    if (fontSize == smallFonts) return 1;
    if (fontSize == mediumFonts) return 2;
    return 3;
  }

  double getScale() {
    if (fontSize == smallFonts) return 0.9;
    if (fontSize == mediumFonts) return 1.1;
    return 1.2;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    final themeState = !themeProvider.isLightTheme;
    final fontSize = themeProvider.fontSize;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: TextStyle(fontSize: fontSize),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 26,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/scan');
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 11.0),
            ),
            Text(
              "Choose Preferences",
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            ),
            Divider(height: 5.0, color: Colors.white),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0),
                ),
                Text(
                  'Font Size:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0),
                ),
                Text(
                  'S',
                  style: TextStyle(
                    fontSize: smallFonts,
                    color: Colors.white,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Radio(
                    value: 1,
                    groupValue: selectedRadio(),
                    onChanged: (val) => themeProvider.setFontSize(smallFonts),
                  ),
                ),
                Text(
                  'M',
                  style: TextStyle(
                    fontSize: mediumFonts,
                    color: Colors.white,
                  ),
                ),
                Transform.scale(
                  scale: 0.92,
                  child: Radio(
                    value: 2,
                    groupValue: selectedRadio(),
                    onChanged: (val) => themeProvider.setFontSize(mediumFonts),
                  ),
                ),
                Text(
                  'L',
                  style: TextStyle(
                    fontSize: largeFonts,
                    color: Colors.white,
                  ),
                ),
                Transform.scale(
                  scale: 1.05,
                  child: Radio(
                    value: 3,
                    groupValue: selectedRadio(),
                    onChanged: (val) => themeProvider.setFontSize(largeFonts),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0),
                ),
                Text(
                  'Dark Theme:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                ),
                Transform.scale(
                  scale: getScale(), // Scale changes with the change of Fonts.
                  child: Switch(
                    value: themeState,
                    onChanged: (state) => themeProvider.toggleThemeData(),
                  ),
                ),
              ],
            ),
            Expanded(
              // This  box will cover all the area beneath the Dark Theme option.
              child: Center(
                child: Text(
                  'We are working to add more\n setting features\n till then enjoy the experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.43,
                    fontSize: fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
