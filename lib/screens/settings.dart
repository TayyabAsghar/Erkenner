import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(Erkenner());

class Erkenner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      home: Scaffold(
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
          title: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Text("Settings"),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // TODO: On press
              },
            ),
          ],
          backgroundColor: HexColor("#01A7E1"),
        ),
        body: PreferenceSelection(),
        backgroundColor: HexColor("#0E1B2B"),
      ),
    );
  }
}

class PreferenceSelection extends StatefulWidget {
  PreferenceSelection({Key key}) : super(key: key);

  @override
  _PreferenceSelection createState() => _PreferenceSelection();
}

class _PreferenceSelection extends State<PreferenceSelection> {
  int selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 2;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 11.0),
          ),
          Text(
            "Choose Preferences",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          ),
          Divider(height: 5.0, color: Colors.white),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              ),
              Text(
                'Font Size:',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
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
                groupValue: selectedRadio,
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
              Text(
                'M',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Radio(
                value: 2,
                groupValue: selectedRadio,
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
              Text(
                'L',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Radio(
                value: 3,
                groupValue: selectedRadio,
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
              ),
              Text(
                'Dark Theme:',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 80.0),
          ),
          Row(
            children: <Widget>[
              Text(
                'We are working to add more',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.7),
          ),
          Row(
            children: <Widget>[
              Text(
                'setting features',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.7),
          ),
          Row(
            children: <Widget>[
              Text(
                'till then enjoy the experience.',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
