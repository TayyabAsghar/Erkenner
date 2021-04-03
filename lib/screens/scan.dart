import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/models/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

// ignore: must_be_immutable
class Scan extends StatefulWidget {
  @override
  ScanState createState() {
    return new ScanState();
  }
}

class ScanState extends State<Scan> {
  List _outputs;
  bool _loading = false;

  // Input file
  File imageFile;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/gtrab_model.lite",
        labels: "assets/labels.txt",
      );
      _loading = true;
    } catch (e) {
      print('error loading model');
      print(e);
    }
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 5,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
    print(output);
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile == null) return null;
    setState(() {
      _loading = true;
      imageFile = File(imageFile.path);
    });
    classifyImage(imageFile);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.red,
  //       title: Text("Erkenner"),
  //     ),
  //     body: _loading
  //         ? Container(
  //       alignment: Alignment.center,
  //       //child: CircularProgressIndicator(),
  //     )
  //         : Container(
  //       width: MediaQuery.of(context).size.width,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           imageFile == null ? Container() : Image.file(imageFile),
  //           Text("Predictions")
  //           SizedBox(
  //             height: 20,
  //           ),
  //           _outputs != null
  //               ? Text(
  //             "${_outputs[0]["label"]}",
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 20.0,
  //               background: Paint()..color = Colors.white,
  //             ),
  //           )
  //               : Container()
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: pickImage,
  //       backgroundColor: Colors.red,
  //       child: Icon(Icons.image),
  //     ),
  //   );
  // }

  _openGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _loading = true;
      imageFile = File(picture.path);
    });

    classifyImage(imageFile);
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });

    classifyImage(imageFile);
    Navigator.of(context).pop();
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
          children: <Widget>[
            _decideImage(fontSize),
            Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //imageFile == null ? Container() : Image.file(imageFile),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Predictions Suck"),
                  imageFile == null
                      ? Container()
                      : _outputs != null
                          ? Text(
                              "${_outputs[0]["label"]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  background: Paint()..color = Colors.white),

                              // _outputs != null ?
                              // Text(_outputs[0]["labels"],style: TextStyle(color: Colors.white ,fontSize: 20),
                            )
                          : Container(child: Text(""))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            RaisedButton(
              onPressed: () {
                _showChoice(context, isLightTheme, fontSize);
              },
              child: Text("Select Image"),
            )
          ],
        ))));
  }
}
