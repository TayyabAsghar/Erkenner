import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/models/theme.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).fontSize;

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
          "History",
          style: TextStyle(
            fontSize: fontSize,
          ),
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
    );
  }
}
