import 'package:flutter/material.dart';

void main() {
  runApp(Erkenner());
}

class Erkenner extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0E1B2B),
      appBar: AppBar(
          centerTitle: true,
          title: Text("Home",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  fontStyle: FontStyle.italic)),
          backgroundColor: Color(0xff01A7E1),
          actions: [
            IconButton(
                icon: Icon(Icons.camera_alt_rounded),
                color: Colors.white,
                iconSize: 24,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                onPressed: () {}),
          ]),
      drawer: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
        child: Drawer(
          backgroundColor: Color(0xff01A7E1),
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new HomePage()));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                },
              ),
              ListTile(
                title: Text('History'),
                onTap: () {
                  /* Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new HistoryPage())); */
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                },
              ),
              ListTile(
                title: Text('About us'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new AboutPage()));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new PreferenceSelection()));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
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
                      "Hi! I am Erkenner Here to Help You Recognize all type of traffic signals...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 6.0,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                    ),
                    width: 300,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: []),
            FlatButton(
              onPressed: () {},
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
