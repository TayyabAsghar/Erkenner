import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/models/theme.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Scan extends StatefulWidget {
  @override
  ScanState createState() {
    return new ScanState();
  }
}

class ScanState extends State<Scan> {
  File imageFile;

  @override
  void initState() {
    super.initState();
  }

  _openGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() => imageFile = picture);
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() => imageFile = picture);
    Navigator.pop(context);
  }

  Widget _decideImage(final fontSize) {
    if (imageFile == null)
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 36),
        child: Text(
          "No Image Selected",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize + 2,
            fontFamily: 'Roboto',
            color: Colors.red[400],
          ),
        ),
      );
    else
      return Image.file(
        imageFile,
        width: 450,
        height: 450,
      );
  }

  Future<void> _showChoice(
    BuildContext context,
    final isLightTheme,
    final fontSize,
  ) async {
    showDialog(
      context: context,
      // ignore: missing_return
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Make a Choice!",
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'Roboto',
              //color: isLightTheme ? Colors.black : Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera_alt_rounded,
                    size: fontSize,
                    //color: isLightTheme ? Colors.black : Colors.white,
                  ),
                  title: Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: 'Roboto',
                      //color: isLightTheme ? Colors.black : Colors.white,
                    ),
                  ),
                  onTap: () => _openCamera(context),
                ),
                ListTile(
                  leading: Icon(
                    Icons.collections,
                    size: fontSize,
                    //color: isLightTheme ? Colors.black : Colors.white,
                  ),
                  title: Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: 'Roboto',
                      //color: isLightTheme ? Colors.black : Colors.white,
                    ),
                  ),
                  onTap: () => _openGallery(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    final isLightTheme = themeProvider.isLightTheme;
    final fontSize = themeProvider.fontSize;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Image Captured",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize + 4,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _decideImage(fontSize),
              RaisedButton(
                shape: StadiumBorder(),
                onPressed: () => _showChoice(context, isLightTheme, fontSize),
                child: Text(
                  "Select Image",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontFamily: 'Roboto',
                    color: isLightTheme ? Colors.black : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
