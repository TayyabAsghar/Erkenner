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
          title: Text("Welcome!",
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
      drawer: Drawer(
        child: Text('Hello World'),
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
