import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _decideImage() {
    if (imageFile == null) {
      return Text("No Image Selected");
    }
    else {
      return Image.file(imageFile, width: 400, height: 400,);
    }
  }

  Future<void> _showChoice(BuildContext context) async {
    showDialog(context: context,
        // ignore: missing_return
        builder: (context) {
          return AlertDialog(
            title: Text("Make a Choice!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0),),

                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Captured"),
        ),
        body: Container(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _decideImage(),
                    RaisedButton(onPressed: () {
                      _showChoice(context);
                    }, child: Text("Select Image"),)
                  ],
                )
            )
        )
    );
  }
}
