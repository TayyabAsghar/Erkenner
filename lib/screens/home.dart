import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/models/theme.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).fontSize;
    final iconSize = fontSize + 6; // IconSize also changes with fontSize

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize + 4,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.6,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.camera_alt_rounded,
              color: Colors.white,
              size: 26,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            onPressed: () => Navigator.pushNamed(context, '/scan'),
          ),
        ],
      ),
      drawer: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 80.0, 130.0, 0.0),
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.history,
                  size: iconSize,
                ),
                title: Text(
                  'History',
                  style: TextStyle(fontSize: fontSize),
                ),
                onTap: () {
                  Navigator.pop(context); // This will close the Drawer.
                  Navigator.pushNamed(context, '/history');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  size: iconSize,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: fontSize),
                ),
                onTap: () {
                  Navigator.pop(context); // This will close the Drawer.
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.supervised_user_circle,
                  size: iconSize,
                ),
                title: Text(
                  'About us',
                  style: TextStyle(fontSize: fontSize),
                ),
                onTap: () {
                  Navigator.pop(context); // This will close the Drawer.
                  Navigator.pushNamed(context, '/about');
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      "Hi! I am Erkenner Here to Help You Recognize all type of traffic signals.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .apply(fontSizeDelta: fontSize),
                      // style: TextStyle(
                      //   fontSize: fontSize,
                      //   fontWeight: FontWeight.bold,
                      //   wordSpacing: 3.0,
                      //   letterSpacing: 0.6,
                      //   height: 1.3,
                      //   color: Colors.white,
                      // ),
                    ),
                    width: 300,
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  onPressed: () => Navigator.pushNamed(context, '/scan'),
                  child: Text(
                    "Get Started",
                    style: TextStyle(fontSize: fontSize, fontFamily: 'Roboto'),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
