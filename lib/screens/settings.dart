import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/models/theme.dart';

class Settings extends StatelessWidget {
  final double fontSize;
  final small = 14.0;
  final medium = 16.0;
  final large = 22.0;

  Settings({@required this.fontSize});

  // @override
  // void initState() {
  //   super.initState();
  //   selectedRadio = 2;
  // }

  int selectedRadio() {
    if (fontSize == small) return 1;
    if (fontSize == medium) return 2;
    return 3;
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
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                Radio(
                  value: 1,
                  groupValue: selectedRadio(),
                  onChanged: (val) => themeProvider.setFontSize(small),
                ),
                Text(
                  'M',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                Radio(
                  value: 2,
                  groupValue: selectedRadio(),
                  onChanged: (val) => themeProvider.setFontSize(medium),
                ),
                Text(
                  'L',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Radio(
                  value: 3,
                  groupValue: selectedRadio(),
                  onChanged: (val) => themeProvider.setFontSize(large),
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
                Switch(
                  value: themeState,
                  onChanged: (state) => themeProvider.toggleThemeData(),
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
