import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(Erkenner());
}

class Erkenner extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutPage()
    );
  }
}

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0E1B2B),
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // TODO: On press
            },
          ),
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Text("About"),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(icon:  Icon(Icons.camera_alt),
                color: Colors.white,
                iconSize: 30,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                onPressed: () {}),
          ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 50
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "Hi! I am Erkenner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Calibri",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 8.0),
                child: Container(
                  child: Text(
                    "Here to help you recognize all types of Traffic Signals.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Calibri",
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
          SizedBox(
              height: 20
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "How it Works?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Calibri",
                      fontWeight: FontWeight.bold,
                      wordSpacing: 6.0,
                      letterSpacing: 0.6,
                      color: Colors.white,
                    ), // resume
                  ),
                  width: 300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
