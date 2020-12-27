import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () => Navigator.pop(context),
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
                }),
          ]),
      body: Column(
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
                padding: const EdgeInsets.only(
                    top: 0.0, left: 8.0, right: 8.0, bottom: 8.0),
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
          SizedBox(height: 20),
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
