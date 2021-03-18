import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/services.dart';

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
        asynch: true
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
    print(output);
  }

  @override
  void dispose(){
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
                          imageFile == null ? Container() :  _outputs != null ?
                                          Text("${_outputs[0]["label"]}",
                                          style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          background: Paint()..color = Colors.white),

                          // _outputs != null ?
                          // Text(_outputs[0]["labels"],style: TextStyle(color: Colors.white ,fontSize: 20),
                          ) : Container(child: Text(""))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

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